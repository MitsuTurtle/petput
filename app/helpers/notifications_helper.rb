module NotificationsHelper

  def notification_form(notification)
    @comment=nil
    visitor=link_to notification.visitor.nickname, notification.visitor, style:"font-weight: bold;"
    your_photo = link_to 'あなたの投稿', notification.photo, style:"font-weight: bold;"
    case notification.action
      when "follow" then
        "#{visitor}があなたをフォローしました"
      when "like" then
        "#{visitor}が#{your_photo}にいいね！しました"
      when "comment" then
        @comment = Comment.find_by(id: notification.comment_id).text
        "#{visitor}が#{your_photo}にコメントしました"
      when "dm" then
        dm_link = link_to "DM", room_path(notification.room.id)
        "#{visitor}があなたに#{dm_link}を送りました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end