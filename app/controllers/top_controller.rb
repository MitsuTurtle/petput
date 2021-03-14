class TopController < ApplicationController
  def index
    @photos = Photo.order(created_at: 'DESC')
    # ↓ページネーション用コード
    @photos = @photos.page(params[:page]).per(12)
  end
end
