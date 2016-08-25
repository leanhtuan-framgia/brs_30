class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :load_gender, only: :new
  before_action :find_user, only: :show

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

  def show
    @activities = @user.activities.order_by.paginate page: params[:page],
      per_page: Settings.size
    @books_favorite = Book.get_book_favorite(@user.id)
      .paginate page: params[:page], per_page: Settings.size
    @relationship = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
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

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "flash.user_nil"
      redirect_to root_url
    end
  end
end
