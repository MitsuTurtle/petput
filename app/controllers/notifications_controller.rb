class NotificationsController < ApplicationController

  def index
    #current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications.order(id: "DESC")
    #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications
    @notifications.destroy_all
    redirect_to notifications_path
  end



end
