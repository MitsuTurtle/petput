class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)

    # 通知の作成（ここから）
    @comment_photo = comment.photo
    @comment_photo.create_comment_notification_by(current_user, comment.id)
    # 通知の作成（ここまで）

    @comments = comment.photo.comments.includes(:user) # Ajax用インスタンス変数
    @photo = comment.photo # Ajax用インスタンス変数
    @comment = Comment.new # Ajax用インスタンス変数
    # redirect_to photo_path(comment.photo.id)
    render 'comment.js.erb'
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    if params[:id] == 'a'
      comments = @photo.comments
      comments.destroy_all
      # redirect_to photo_path(photo)
      render 'destroy_all.js.erb'
    else
      comment = Comment.find(params[:id])
      comment.destroy
      @comment_id = params[:id]
      # redirect_to photo_path(photo)
      render 'destroy.js.erb'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, photo_id: params[:photo_id])
  end
end
