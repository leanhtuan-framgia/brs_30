class BooksController < ApplicationController
  before_action :find_book, only: :show

  def index
    @books = Book.paginate page: params[:page], per_page: Settings.size
  end

  def show
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
