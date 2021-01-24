class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      # redirect_to "/rooms/#{@message.room_id}"
      render 'create.js.erb'
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    # redirect_back(fallback_location: root_path)
    render 'destroy.js.erb'
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id)
  end
end
