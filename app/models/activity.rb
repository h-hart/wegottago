class Activity < ActiveRecord::Base
  attr_accessible :age_all, :age_from, :age_to, :details, 
                  :end_datetime, :gender_female, :gender_male, 
                  :location, :orientation_bisexual, :orientation_gay, 
                  :orientation_straight, :people_ask_others, :people_number, 
                  :personal_quote, :status_in_relationship, :status_married, 
                  :status_single, :theme_id, :title, :kids, :no_kids, 
                  :expecting_kids, :interest_tag_list, :date, :time, :user_id, 
                  :lat, :lng

  acts_as_taggable_on :interest_tags

  attr_accessor :date, :time

  # Relations
  has_and_belongs_to_many :activity_categories
  belongs_to :user
  belongs_to :theme
  has_many :activity_join, :dependent => :destroy
  has_many :curiosities,   :dependent => :destroy
  has_many :comments,      :dependent => :destroy
  has_many :guest_views,   :as          => :recipient, 
                           :class_name  => 'PublicActivity::Activity',
                           :foreign_key => 'recipient_id', 
                           :dependent => :destroy

  before_create :connect_categories

  validates :theme_id, :title, :personal_quote, :end_datetime, :location, :lat, :lng, 
            :details, :people_number, :user_id, presence: true

  def self.filter user 
    self.where("user_id != ?", user.id)
    .order('activities.end_datetime ASC')
    .where('activities.end_datetime >= ?', Time.now)
    .where('( activities.age_all is TRUE ) OR ( activities.age_from <= ? AND activities.age_to >= ? ) OR (activities.age_all is FALSE AND activities.age_from is NULL AND activities.age_to is NULL)', user.age, user.age)
    .where(user.kids_query('activities'))
    .where(user.gender_query('activities'))
    .where(user.status_query('activities'))
    .where(user.orientation_query('activities'))
  end

  def if_user_joined user_id
    num = ActivityJoin.where("activity_id = ? AND user_id = ?", id, user_id).count
    return num > 0 ? true : false
  end

  def user_unjoin user_id
    obj = ActivityJoin.where("activity_id = ? AND user_id = ?", id, user_id)
    obj.destroy_all
  end

  def if_user_curious user_id
    num = Curiosity.where("activity_id = ? AND user_id = ?", id, user_id).count
    return num > 0 ? true : false
  end

  def user_incurious user_id
    obj = Curiosity.where("activity_id = ? AND user_id = ?", id, user_id)
    obj.destroy_all
  end

  def if_all_spots_occupied
    people_number <= activity_join.count
  end

  def joins_count
    if if_all_spots_occupied
      people_number - 1
    else
      activity_join.count - 1
    end
  end

  def show_joins_count
    joins_count.to_s + if joins_count == 1 
      " person is goin so far"
    else
      " people are goin so far"
    end
  end

  def free_spot_num
    people_number - activity_join.count
  end

  def all_occupied_spots
    get_occupied_spots people_number
  end

  def get_five_occupied_spots
    get_occupied_spots 5
  end

  def get_occupied_spots num
    ActivityJoin.where("activity_id = ? AND user_id != ?", id, user.id).order('id ASC').limit(num)
  end

  private 
    def connect_categories
      ActivityCategory.tagged_with(interest_tag_list, :any => true).each do |activity_category|
        self.activity_categories << activity_category
      end
    end
end
