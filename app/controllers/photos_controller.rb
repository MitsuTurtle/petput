class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.order('created_at DESC')
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @photo.comments.includes(:user)
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      redirect_to photo_path
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to root_path
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :caption, :category_id).merge(user_id: current_user.id)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end
end
