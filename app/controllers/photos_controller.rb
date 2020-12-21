class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :search_category_photo, only: [:index, :category, :hashtag, :search]

  def index
    # @photos = Photo.order('created_at DESC')
    @photos = Photo.all.shuffle
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
    @user = Photo.find_by(params[:id]).user
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

  def search
    if params[:keyword].present?
      @photos = Photo.where('caption LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      redirect_to root_path
    end
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @photos = @tag.photos
    # @photo = @tag.photos.page(params[:page])
  end

  def category
    # ↓includesを記入するか検討
    @photos = @q.result
    category_id = params[:q][:category_id_eq]
    if category_id.present? 
      @category = Category.find_by(id: category_id)
    else
      redirect_to root_path
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :caption, :category_id).merge(user_id: current_user.id)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def search_category_photo
    @q = Photo.ransack(params[:q])
  end

end
