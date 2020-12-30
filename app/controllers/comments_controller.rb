class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    @comments = comment.photo.comments # Ajax用インスタンス変数
    @photo = comment.photo # Ajax用インスタンス変数
    @comment = Comment.new # Ajax用インスタンス変数
    # redirect_to photo_path(comment.photo.id)
    render 'comment.js.erb'
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, photo_id: params[:photo_id])
  end
end
