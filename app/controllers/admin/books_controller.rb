class Admin::BooksController < Admin::BaseController
  before_action :load_categories, only: [:new, :edit]
  before_action :find_book, except: [:index, :new, :create]

  def index
    @books = Book.paginate page: params[:page], per_page: Settings.size
  end

  def show
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "flash.add_book_success"
      redirect_to @book
    else
      load_categories
      render :new
    end
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "flash.edit_book_success"
      redirect_to admin_book_path @book
    else
      load_categories
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "flash.delete_book_success"
      redirect_to admin_books_path
    else
      flash[:danger] = t "flash.delete_book_failed"
      redirect_to admin_book_path @book
    end
  end

  private
  def book_params
    params.require(:book).permit :title, :publish_date, :author,
      :number_of_page, :category_id, :picture
  end

  def load_categories
    @categories = Category.all
    @category_selects = @categories.collect{|category| [category.name,
      category.id]}
  end

  def find_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      flash[:danger] = t "flash.cant_find_book"
      redirect_to admin_books_path
    end
  end
end
