class User::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
     @message = current_user.messages.new(message_params)
     @message.save
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
 
  def message_params
  params.require(:message).permit(:content, :room_id)
  end
 
end
