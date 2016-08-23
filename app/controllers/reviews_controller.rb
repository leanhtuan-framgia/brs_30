class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show]
  before_action :find_book, only: :new
  before_action :find_review, only: :show

  def new
    @review = current_user.reviews.new
  end

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:success] = t "flash.write_review_success"
      redirect_to @review
    else
      render :new
    end
  end

  def show
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
end
