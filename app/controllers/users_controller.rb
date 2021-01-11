class UsersController < ApplicationController
  before_action :search_category_photo, only: :show

  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @photos = @user.photos
    @profile = @user.profile
  end

  def following
    @title = "フォロー中"
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def search_category_photo
    @q = Photo.ransack(params[:q])
  end
end
