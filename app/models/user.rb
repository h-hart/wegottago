class User < ActiveRecord::Base
  rolify
  acts_as_taggable_on :interests
  acts_as_messageable

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable, 
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable

  # Setup accessible (or protected) attributes for your model
  # age - is a virtual attribute
  attr_accessible :name, :email, :password, :password_confirmation, 
                  :remember_me, :confirmed_at, :uid, :provider, :avatar,
                  :crop_x, :crop_y, :crop_h, :crop_w, :last_name, :sex,
                  :zipcode, :occupation, :relationship_status, :loc_lng,
                  :looking_for, :about, :have_kids, :wants_kids, :ethnicity,  
                  :body_type, :height, :faith, :smoke, :drink, :orientation,
                  :show_initials, :age_private, :visible_for_registered,
                  :birthdate, :user_notification_attributes, :location, :age,
                  :interest_list, :friend_preference_attributes, :loc_lat,
                  :last_activity_datatime

  # relations
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends,  :through => :inverse_friendships, :source => :user
  has_many :activities,       dependent: :destroy
  has_many :themes,           dependent: :destroy
  has_many :activity_join,    dependent: :destroy
  has_many :curiosities,      dependent: :destroy
  has_many :comments,         dependent: :destroy
  has_one :user_notification, dependent: :destroy
  has_one :friend_preference, dependent: :destroy

  # Nested fields
  accepts_nested_attributes_for :user_notification
  accepts_nested_attributes_for :friend_preference

  # Callbacks
  before_validation :add_password_confirmation
  after_create :add_default_role
  before_create :create_friend_preference

  # Validations
  validates :name, presence: true
  validates :name, :last_name, :occupation, :email,:relationship_status , 
            :last_name, :looking_for, :sex, :have_kids, :wants_kids, 
            :ethnicity, :body_type, :height, :faith, :smoke, :drink, 
            :orientation, :location,
            length: { maximum: 256 }
  validates :about, length: { maximum: 1000 }
  validates :age, numericality: { greater_than: 0, less_than_or_equal_to: 100 },
            on: :update, :if => lambda { self.age }
  validates :zipcode, numericality: { greater_than: 0 }, 
            on: :update, :if => lambda { self.zipcode }

  mount_uploader :avatar, AvatarUploader

  self.per_page = 10

  # Class methods
  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    return user if user
    unless user
      user = where(email: auth.info.email).first_or_create do |user|
        user.provider  = auth.provider
        user.uid       = auth.uid
        # There may me issues with params that return facebook
        if auth.info.first_name && auth.info.last_name
          user.name      = auth.info.first_name
          user.last_name = auth.info.last_name
        elsif auth.info.nickname
          names          = auth.info.nickname.split('.').map{|e| e.capitalize}
          user.name      = names[0]
          user.last_name = names[1]
        elsif auth.info.name
          names          = auth.info.name.split(' ').map{|e| e.capitalize}
          user.name      = names[0]
          user.last_name = names[1]
        end
        user.email     = auth.info.email
      end

      if user.provider.blank?
        user.provider = auth.provider
        user.uid = auth.uid
        user.save
      end
      user
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      unless params.empty?
        user = find_by_email(params[:email])
        if user
          user.destroy unless user.confirmed?
        end
      end
      super
    end
  end

  # Virtual age field
  def age=(val)
    self.birthdate = Date.new( Date.today.year - val.to_i )
  end
  def age
    birthdate ? Date.today.year - birthdate.strftime('%Y').to_i : ''
  end
  def show_age?
    age_private && age != 0 && !age.blank?
  end

  def wizard_complited?
    # zipcode and age are validated with presence in this model.
    provider && zipcode && age
  end

  # For FB-oauth
  def password_required?
    super && provider.blank?
  end
  def confirmation_required?
    super && provider.blank?
  end
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  # Resizes image using params crop_*
  def reprocess_profile
    self.avatar.recreate_versions!
  end


  def accost
    sex == 'Male' ? 'his' : 'her'
  end

  def email_provider
    self.email.match(/@.*\./)[0].gsub('@', '').gsub('.', '').capitalize
  end

  def email_provider_site
    "http://"+self.email.match(/@.*/)[0].gsub('@', '')
  end

  def fullname
    if self.show_initials
      ln = last_name ? last_name[0] : ''
    else
      ln = last_name
    end
    "#{name} #{ln}"
  end

  def fullname_initials
    if self.show_initials
      ln = !last_name.blank? ? last_name[0].to_s + '.' : ''
    else
      ln = last_name
    end
    "#{name} #{ln}"
  end

  def location_short
    location.split(',').reverse.drop(1).reverse.join(',')
  end

  def all_friendships
    self.friendships + self.inverse_friendships
  end

  def get_friends(limit = 0)
    friends = User.joins("LEFT JOIN friendships ON (friendships.user_id = users.id OR friendships.friend_id = users.id)")
                  .where("users.id != ? ", id)
                  .where("(friendships.user_id = ? or friendships.friend_id = ?) and friendships.approved = ?", id, id, true)
    friends = friends.limit(limit) if limit > 0
    friends
  end

  def get_friend_request
    User.joins("LEFT JOIN friendships ON friendships.user_id = users.id")
    .where("friendships.friend_id = ? and friendships.approved = ?", id, false)
  end

  def pending_friend_requests
    Friendship.where("(friend_id = ?) and approved = ?", id, false)
  end

  def pending_friend(pending_user_friend_request)
    if pending_user_friend_request.user_id == self.id
      pending_user_friend_request.friend
    else
      pending_user_friend_request.user
    end
  end


  def get_friendship(params)
    friendship = Friendship.where("(user_id = ? and friend_id = ?) or (user_id = ? and friend_id = ?)", id, params[:friend_id], params[:friend_id], id)
  end

  def count_of_friends
    friendships = Friendship.where("(user_id = ? or friend_id = ?) and approved = ?", id, id, true).count
  end

  def allow_friend_request_notification?
    return false unless user_notification
    self.user_notification.friend_requests
  end

  def mailboxer_email(object)
    email
  end

  def get_all_curious_activities
    Activity.select("activities.*, curiosities.id as cur_id")
    .joins('LEFT JOIN curiosities ON activities.id = curiosities.activity_id')
    .where("curiosities.user_id = ? AND curiosities.id IS NOT NULL", id)
    .order('cur_id DESC')
  end

  def curious_activities_num
    Activity.select("activities.id")
    .joins('LEFT JOIN curiosities ON activities.id = curiosities.activity_id')
    .where("curiosities.user_id = ? AND curiosities.id IS NOT NULL", id)
    .count
  end

  def kids_query tabl
    query = "( #{tabl}.kids is FALSE AND #{tabl}.no_kids is FALSE AND #{tabl}.expecting_kids is FALSE )"
    query += " OR ( #{tabl}.kids is TRUE )"           if have_kids == 'Have Kids'
    query += " OR ( #{tabl}.no_kids is TRUE )"        if have_kids == 'No kids'
    query += " OR ( #{tabl}.expecting_kids is TRUE )" if have_kids == 'Expecting'
    query
  end

  def gender_query tabl
    query = "( #{tabl}.gender_male is FALSE AND #{tabl}.gender_female is FALSE)"
    query += " OR ( #{tabl}.gender_male is TRUE )"   if sex == 'Male'
    query += " OR ( #{tabl}.gender_female is TRUE )" if sex == 'Female'
    query
  end

  def status_query tabl
    query = "( #{tabl}.status_single is FALSE AND #{tabl}.status_married is FALSE AND #{tabl}.status_in_relationship is FALSE )"
    query += " OR ( #{tabl}.status_single is TRUE )"          if relationship_status == 'Single'
    query += " OR ( #{tabl}.status_married is TRUE )"         if relationship_status == 'Married'
    query += " OR ( #{tabl}.status_in_relationship is TRUE )" if relationship_status == 'In a relationship'
    query
  end

  def orientation_query tabl
    query = "( #{tabl}.orientation_straight is FALSE AND #{tabl}.orientation_gay is FALSE AND #{tabl}.orientation_bisexual is FALSE )"
    query += " OR ( #{tabl}.orientation_straight is TRUE  )" if orientation == 'Straight'
    query += " OR ( #{tabl}.orientation_gay is TRUE  )"      if orientation == 'Gay'
    query += " OR ( #{tabl}.orientation_bisexual is TRUE  )" if orientation == 'Bisexual'
    query
  end

  def self.filter user
    self.where("users.id != ?", user.id)
    .includes(:friend_preference)
    .where('users.confirmed_at IS NOT NULL or users.provider IS NOT NULL')
    .where('( friend_preferences.age_from <= ? AND friend_preferences.age_to >= ? ) OR ( friend_preferences.age_from is NULL AND friend_preferences.age_to is NULL)', user.age, user.age)
    .where(user.kids_query('friend_preferences'))
    .where(user.gender_query('friend_preferences'))
    .where(user.status_query('friend_preferences'))
    .where(user.orientation_query('friend_preferences'))
  end

  private
    def add_password_confirmation
      password_confirmation = password
    end

    def add_default_role
      add_role :user
    end

    def create_friend_preference
      self.friend_preference = FriendPreference.create(
        :gender_male => false, 
        :gender_female => false,
        :status_single => false,
        :status_married => false,
        :status_in_relationship => false,
        :orientation_straight => false,
        :orientation_gay => false,
        :orientation_bisexual => false,
        :kids => false,
        :no_kids => false,
        :expecting_kids => false
      )
    end

end
