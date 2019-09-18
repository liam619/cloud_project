class CategoriesController < ApplicationController

  before_action :logged_in_user, only: [:new, :create]
  before_action :logged_in_admin, only: [:index, :edit, :update, :destroy]

  def show
    @category = Category.find(params[:id])
    @books = @category.books
  end

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "New category #{@category.name} created."
      redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category successful updated."
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    category = Category.find(params[:id]).destroy
    flash[:success] = "#{category.name} removed."
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end