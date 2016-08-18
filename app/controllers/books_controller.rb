class BooksController < ApplicationController
  before_action :logged_in_user, :find_book, only: :show

  def index
    @books = Book.paginate page: params[:page], per_page: Settings.size
  end

  def show
    @read_statuses = UserBook.read_statuses
    @user_book = current_user.user_books.find_by book_id: @book.id
    @user_book ||= @book.user_books.new
    @checked_status = @user_book.read_status
  end

  private
  def find_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      flash[:danger] = t "flash.cant_find_book"
      redirect_to books_path
    end
  end
end
