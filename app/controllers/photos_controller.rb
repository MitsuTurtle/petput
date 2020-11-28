class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)

  end

  private

  def photo_params
    params.require(:photo).permit(:image,:caption, :category_id).merge(user_id: current_user.id)
  end


end
