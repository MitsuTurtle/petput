class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :search_category_photo, only: [:index, :category, :hashtag, :search, :show]
  before_action :set_dm_room_id, only: [:index, :category, :hashtag, :search]

  def index
    @photos = Photo.order(created_at: 'DESC')
    # @photos = Photo.all.shuffle
    # ↓ページネーション用コード
    @photos = @photos.page(params[:page]).per(12)
    @followings_photos = []
    if user_signed_in?
      current_user.followings.each do |following|
        @followings_photos.concat(following.photos)
      end
      @my_timeline_photos = @followings_photos.concat(current_user.photos)
      @my_timeline_photos = @my_timeline_photos.sort { |a, b| b[:id] <=> a[:id] }
    end
    # ↓ページネーション用コード
    @my_timeline_photos = Kaminari.paginate_array(@my_timeline_photos).page(params[:page]).per(12)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photos_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @photo.comments.order(created_at: 'ASC').includes(:user)
    @user = Photo.find(params[:id]).user

    respond_to do |format|
      format.html
      format.js
    end
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
    redirect_to photos_path
  end

  def search
    if params[:keyword].present?
      @photos = Photo.where('caption LIKE ?', "%#{params[:keyword]}%").order(created_at: 'DESC')
      @keyword = params[:keyword]
    else
      redirect_to request.referer
    end
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @photos = @tag.photos.order(created_at: 'DESC')
    # @photo = @tag.photos.page(params[:page])
  end

  def category
    # ↓includesを記入するか検討
    @photos = @q.result.order(created_at: 'DESC')
    category_id = params[:q][:category_id_eq]
    if category_id.present?
      @category = Category.find_by(id: category_id)
    else
      redirect_to request.referer
    end
  end

  # いいね
  def like
    current_user.voted_photos << @photo

    # 通知の作成（ここから）
    @photo.create_like_notification_by(current_user)
    render 'vote.js.erb'
    # 通知の作成（ここまで）

    # redirect_to photo_path, notice: "いいねしました。"
  end

  # いいね削除
  def unlike
    current_user.voted_photos.destroy(@photo)
    render 'vote.js.erb'
    # redirect_to photo_path, notice: "削除しました。"
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

  def set_dm_room_id
    # DM用インスタンス変数
    if user_signed_in? && current_user.entries.present?
      cu_latest_entry = current_user.entries.order(created_at: 'DESC').take
      @cu_latest_room_id = Room.find(cu_latest_entry.room_id).id
    end
  end
end
