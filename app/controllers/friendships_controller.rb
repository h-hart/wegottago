class FriendshipsController < ApplicationController
  before_filter :authenticate_user!
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Request sent."
      redirect_to(:back)
    else
      flash[:error] = "Unable to add friend."
      redirect_to(:back)
    end
  end

  def update
    user = User.find(params[:friend_id])
    @friendship = user.friendships.find(params[:id])
    @friendship.approved = true
    if @friendship.save
      flash[:notice] = "Approved friendship."
      redirect_to(:back)
    else
      flash[:error] = "Unable to approve friend."
      redirect_to(:back)
    end
  end

  def destroy
    @friendship = Friendship.where("(user_id = ? and friend_id = ?) or (user_id = ? and friend_id = ?)", current_user.id, params[:friend_id], params[:friend_id], current_user.id)

    @friendship[0].destroy
    flash[:notice] = "Removed friendship."
    redirect_to(:back)
  end
end
