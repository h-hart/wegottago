class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    comments = Comment.where('activity_id = ?', params[:id]).order('id DESC')

    send = []
    comments.each do |comment|
      send.push({name: comment.user.name,
                 avatar: comment.user.avatar_url(:thumb),
                 joined: comment.activity.if_user_joined(current_user.id),
                 text: comment.text})
    end

    render :json => send
  end

  def create
    @comment = Comment.new
    @comment.activity_id = params[:id]
    @comment.user_id = current_user.id
    @comment.text = params[:comment]

    if @comment.save
      render text:'ok'
    else
      render text:'err'
    end
  end
end
