class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create

  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :iamge).merge(user_id: current_user.id)
  end


end
