class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :find_book, only: :new
  before_action :find_review, except: [:new, :create]

  def new
    @review = current_user.reviews.new
  end

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:success] = t "flash.write_review_success"
      redirect_to @review
    else
      @book =Book.find_by id: params[:book_id]
      render :new
    end
  end

  def edit
  end

  def destroy
    if @review.destroy
      flash[:success] = t "flash.delete_review_success"
      redirect_to @review.book
    end
  end

  def show
    init_comment
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "flash.edit_review_success"
      redirect_to @review
    else
      render :edit
    end
  end

  private
  def find_book
    @book = Book.find_by id: params[:book_id]
    if @book.nil?
      flash[:danger] = t "flash.cant_find_book_to_review"
      redirect_to new_review_path
    end
  end

  def find_review
    @review = Review.find_by id: params[:id]
    if @review.nil?
      flash[:danger] = t "flash.cant_find_review"
      redirect_to root_path
    end
  end

  def review_params
    params.require(:review).permit :title, :content, :book_id
  end

  def init_comment
    @comment = Comment.new
  end
end
