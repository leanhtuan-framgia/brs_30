class UserBooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :update]
  before_action :find_user_book, only: :update

  def create
    @user_book = current_user.user_books.build user_book_params
    if @user_book.save
      flash[:success] = t "flash.mark_book_success"
    else
      flash[:danger] = t "flash.cant_create_request_status"
    end
    redirect_to @user_book.book
  end

  def update
    if @user_book.update user_book_params
      flash[:success] = t "flash.mark_book_success"
    else
      flash[:danger] = t "flash.cant_create_request_status"
    end
    redirect_to @user_book.book
  end

  private
  def find_user_book
    @user_book = current_user.user_books.find_by book_id: params[:id]
    if @user_book.nil?
      flash[:danger] = t "flash.cant_find_userbook"
      redirect_to book_path
    end
  end

  def user_book_params
    params.require(:user_book).permit :read_status, :favorite, :book_id
  end
end
