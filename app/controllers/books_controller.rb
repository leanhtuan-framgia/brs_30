class BooksController < ApplicationController
  before_action :load_categories, only: [:new, :edit]
  before_action :find_book, except: [:index, :new, :create]
  before_action :load_book_list, only: [:index, :destroy]

  def index
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t("flash.add_book_success")
      redirect_to @book
    else
      load_categories
      render :new
    end
  end

  def show
  end

  def new
    @book = Book.new
  end

  private
  def book_params
    params.require(:book).permit :title, :publish_date, :author,
     :number_of_page, :category_id, :picture
  end

  def load_categories
    @categories = Category.all
    @category_selects = @categories.collect{|cat| [cat.name, cat.id]}
  end

  def find_book
    @book = Book.find_by id: params[:id]
  end

  def load_book_list
    @books = Book.paginate page: params[:page], per_page: Settings.size
  end
end
