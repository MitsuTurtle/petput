class UsersController < ApplicationController
  before_action :set_user, only: [:show, :favorites]
  before_action :search_category_photo, only: [:show, :favorites]
  before_action :set_dm_room_id, only: :show

  def show
    @nickname = @user.nickname
    @photos = @user.photos.order(created_at: 'DESC')
    @profile = @user.profile
    @favorite_photos = @user.favorite_photos.order(created_at: 'DESC')

    if user_signed_in?
      @current_user_entries = Entry.where(user_id: current_user.id)
      @user_entries = Entry.where(user_id: @user.id)

      if @user.id != current_user.id
        @current_user_entries.each do |cu|
          @user_entries.each do |u|
            if cu.room_id == u.room_id
              @is_room = true
              @room_id = cu.room_id
            end
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def following
    @title = 'フォロー中'
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def favorites
    @favorite_photos = @user.favorite_photos.order(created_at: 'DESC')
  end

  private

  def set_user
    @user = User.find(params[:id])
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
