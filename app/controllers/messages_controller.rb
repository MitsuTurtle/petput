class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)

      # 通知機能（ここから）
      @room = @message.room
      # 配列として取得
      @room_member_not_me_array=Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
      # 配列の要素として取得
      @room_member_not_me=@room_member_not_me_array.find_by(room_id: @room.id)
        notification = current_user.active_notifications.new(
          room_id: @room.id,
          message_id: @message.id,
          visited_id: @room_member_not_me.user_id,
          visiter_id: current_user.id,
          action: 'dm'
      )
      notification.save if notification.valid?
      # 通知機能（ここまで）

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
    params.require(:message).permit(:content, :room_id, :dm_image).merge(user_id: current_user.id)
  end
end