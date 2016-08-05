class UsersController < ApplicationController
  before_action :load_gender, only: :new
  before_action :logged_in_user, except: [:new, :create]
  before_action :verify_admin, only: :destroy
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.signup_success"
      redirect_to root_url
    else
      load_gender
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :phone_number, :gender,
      :password, :password_confirmation
  end

  def load_gender
    @genders = User.genders
  end

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end
end
