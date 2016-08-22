class Admin::CategoriesController < Admin::BaseController
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.size
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flash.add_category_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "flash.edit_category_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "flash.delete_category_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "flash.delete_category_failed"
      redirect_to admin_categories_path
    end
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "flash.cant_find_category"
      redirect_to admin_categories_path
    end
  end

  def category_params
    params.require(:category).permit :name, :description
  end
end
