class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 16)
  end

  def show
    @cat_movies = @category.movies.paginate(page: params[:page], per_page: 8)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category was added successfully!"
      redirect_to category_path(@category)
    else
      render 'create'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category updated."
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:danger] = "Category and associations were removed."
    redirect_to categories_path
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Only admins are allowed to perform this action."
      redirect_to categories_path
    end
  end
end
