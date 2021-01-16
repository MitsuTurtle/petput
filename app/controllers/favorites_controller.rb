class FavoritesController < ApplicationController
  before_action :set_photo, only: [:create, :destroy]
  
  def create
    favorite = current_user.favorites.build(photo_id: params[:photo_id])
    favorite.save
    # redirect_to photo_path(params[:photo_id])
    render 'favorite.js.erb'
  end

  def destroy
    favorite = Favorite.find_by(photo_id: params[:photo_id], user_id: current_user.id)
    favorite.destroy
    # redirect_to photo_path(params[:photo_id])
    render 'favorite.js.erb'
  end

  private
  def set_photo
    @photo = Photo.find(params[:photo_id])
  end


end
