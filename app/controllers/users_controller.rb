class UsersController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :load_gender, only: :new

  def new
    @user = User.new
  end

  def index
    @users = User.paginate page: params[:page], per_page: Settings.size_user
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
end
