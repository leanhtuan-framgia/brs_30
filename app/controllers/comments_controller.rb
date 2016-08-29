class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build comment_params
    @review = @comment.review
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment.update_attributes comment_params
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def find_comment
    @comment = Comment.find_by id: params[:id]
    if @comment.nil?
      flash[:danger] = t "flash.comment_dont_exit"
      redirect_to request.referrer || root_url
    end
    @review = @comment.review
  end

  def comment_params
    params.require(:comment).permit :content, :user_id, :review_id
  end
end
