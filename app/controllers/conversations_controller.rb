class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_mailbox, :get_user
  before_filter :check_current_user_in_conversation, :only => [:show, :update, :destroy]

  def new
    @message = Message.new
  end

  def index
    if @box.eql? "trash"
      @conversations = @mailbox.trash
    else
      @conversations = @mailbox.conversations(mailbox_type: 'not_trash')
    end

    respond_to do |format|
      format.html { render @conversations if request.xhr? }
    end
  end

  def show
    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    @receipts.mark_as_read
    get_unread_messages_and_notification
    render :action => :show
  end


  def destroy

    @conversation.move_to_trash(@user)

    respond_to do |format|
      format.html {
        if params[:location].present? and params[:location] == 'conversation'
          redirect_to conversations_path(:box => :trash)
        else
          redirect_to conversations_path(:box => @box,:page => params[:page])
        end
      }
      format.js {
        if params[:location].present? and params[:location] == 'conversation'
          render :js => "window.location = '#{conversations_path(:box => @box,:page => params[:page])}';"
        else
          render 'conversations/destroy'
        end
      }
    end
  end

  def create
    @recipients =
      if params[:recipients].present?
        @recipients = params[:recipients].split(',').map{ |r| User.find(r) }.flatten
      else
        []
      end

    conversation = Conversation.participant(current_user)
    if @recipients.length == 1 && !conversation.empty?
      conversation = conversation.participant(@recipients.first).first
      conversation = conversation.participants.size > 2 ? nil : conversation
    end

    if !conversation.blank?
      receipt = @user.reply_to_conversation(conversation, params[:body])
    else
      receipt = @user.send_message( @recipients, params[:body], "." )
    end

    if receipt.errors.any?
      render  action: 'new'
    else
      respond_to do |format|
        format.html { redirect_to conversation_path(receipt.conversation.id) }
        format.js   { @message = receipt.message }
      end
    end
  end

  def update
    @conversation.mark_as_unread(current_user)
    redirect_to conversations_path
  end

  def get_status
    user_num = User.where("id = ? AND last_activity_datatime > ?",params[:id], Time.new - 5.minutes).count

    if user_num > 0
      render :json => {status: true}
    else
      render :json => {status: false}
    end
  end

  def update_status
    current_user.last_activity_datatime = Time.new
    if current_user.save(validate: false)
      render text: "{update: ok}"
    else
      render text: "{update: err}"
    end
  end

  private

  def get_mailbox
    @mailbox = current_user.mailbox
  end

  def get_user
    @user = current_user
  end

  def check_current_user_in_conversation
    @conversation = Conversation.find_by_id(params[:id])

    if @conversation.nil? or !@conversation.is_participant?(@user)
      redirect_to conversations_path(:box => @box)
    return
    end
  end

end
