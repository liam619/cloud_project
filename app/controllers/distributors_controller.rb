class DistributorsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :logged_in_admin, only: [:index, :edit, :update, :destroy]

  def show
    @distributor = Distributor.find(params[:id])
    @books = @distributor.books
  end

  def index
    @distributor = Distributor.all
  end

  def new
    @distributor = Distributor.new
  end

  def create
    @distributor = Distributor.new(distributor_params)
    if @distributor.save
      flash[:success] = "New distributor #{@distributor.name} created."
      redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
    @distributor = Distributor.find(params[:id])
  end

  def update
    @distributor = Distributor.find(params[:id])
    if @distributor.update_attributes(distributor_params)
      flash[:success] = "Distributor successful updated."
      redirect_to distributors_path
    else
      render 'edit'
    end
  end

  def destroy
    distributor = Distributor.find(params[:id]).destroy
    flash[:success] = "#{distributor.name} removed."
    redirect_to distributors_path
  end

  private

  def distributor_params
    params.require(:distributor).permit(:name)
  end
end
