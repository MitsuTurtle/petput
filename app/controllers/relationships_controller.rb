class RelationshipsController < ApplicationController
  before_action :set_variables

  def create
    following = current_user.follow(@user)
    if following.save

      # 通知の作成（ここから）
      @user.create_follow_notification_by(current_user)
      # 通知の作成（ここまで）

      # flash[:success] = 'ユーザーをフォローしました'
      # redirect_to user_path(@user)
      render 'follow.js.erb'
    else
      # flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      # redirect_to user_path(@user)
      render 'follow.js.erb'
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      # flash[:success] = 'ユーザーのフォローを解除しました'
      # redirect_to user_path(@user)
      render 'follow.js.erb'
    else
      # flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      # redirect_to user_path(@user)
      render 'follow.js.erb'
    end
  end

  private

  def set_variables
    @user = User.find(params[:follow_id])
    @id_name = "follow-btn-box-#{@user.id}"
  end
end
