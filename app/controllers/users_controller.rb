class UsersController < ApplicationController
  before_action :search_category_photo, only: :show

  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @photos = @user.photos
  end

  private

  def search_category_photo
    @q = Photo.ransack(params[:q])
  end
end
