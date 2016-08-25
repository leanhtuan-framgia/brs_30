class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :find_activity, only: :create
  before_action :find_like, only: :destroy

  def create
    @activity = Activity.find_by id: params[:activity_id]
    current_user.likes.build(activity_id: @activity.id).save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @activity = @like.activity
    @like.destroy
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  private
  def find_activity
    @activity = Activity.find_by_id params[:activity_id]
    if @activity.nil?
      flash[:danger] = t "flash.cant_find_activity"
      redirect_to root_path
    end
  end

  def find_like
    @like = current_user.likes.find_by activity_id: params[:id]
    if @like.nil?
      flash[:danger] = "flash.cant_find_like"
      redirect_to root_path
    end
  end
end
