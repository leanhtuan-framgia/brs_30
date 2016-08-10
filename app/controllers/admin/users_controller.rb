class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_user, only: :destroy

  def index
    @users = User.paginate page: params[:page], per_page: Settings.size_user
  end

  def destroy
    if @user.is_admin?
      flash[:danger] = t "flash.user_no"
      redirect_to users_url
    end
    if @user.destroy
      flash[:success] = t "flash.delete_user"
      redirect_to admin_users_url
    end
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "flash.user_nil"
      redirect_to users_url
    end
  end
end
