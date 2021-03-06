module NotificationsHelper
  def notification_form(notification)
    @comment = nil
    @dm = nil
    visitor = link_to notification.visitor.nickname, user_path(notification.visitor)
    if notification.photo.present?
      your_photo = link_to 'あなたの投稿', photo_path(notification.photo.id)
      your_commented_photo = link_to 'あなたがコメントした投稿', photo_path(notification.photo.id)
    end

    case notification.action
    when 'follow'
      "#{visitor}さんがあなたをフォローしました"
    when 'like'
      "#{visitor}さんが#{your_photo}にいいね！しました"
    when 'comment'
      @comment = Comment.find_by(id: notification.comment_id).text
      if notification.photo.user_id == current_user.id
        "#{visitor}さんが#{your_photo}にコメントしました"
      else
        "#{visitor}さんが#{your_commented_photo}にコメントしました"
      end
    when 'dm'
      @dm = notification.message.content
      dm_link = link_to 'DM', room_path(notification.room.id)
      "#{visitor}さんがあなたに#{dm_link}を送りました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
