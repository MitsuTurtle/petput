class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_category_photo, only: :show
  before_action :set_dm_room_id, only: :show

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(room_params)
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    @rooms = Room.order(created_at: 'DESC')
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.includes(:user)
      @message = Message.new
      @entries = @room.entries
      @current_user_entries = current_user.entries.order(created_at: 'DESC')
    else
      redirect_to photos_path
    end
  end

  private

  def room_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
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
