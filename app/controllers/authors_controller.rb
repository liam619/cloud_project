class AuthorsController < ApplicationController
  before_action :non_user, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :logged_in_admin, only: [:destroy]

  def show
    @user = Author.find(params[:id])
    @books = @user.books
    # Hide certain details from User view profile page
    @hide_for_view = true
  end

  # Index will not display admin user
  def index
    @users = Author.all.where(admin: false)
  end

  def new
    @user = Author.new
  end

  def create
    @user = Author.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Successful register as coordinator."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = Author.find(params[:id])
  end

  def update
    @user = Author.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = Author.find(params[:id]).destroy
    flash[:success] = "#{user.name} removed."
    redirect_to authors_path
  end

  private

  def user_params
    params.require(:author).permit(:name, :email, :password, :password_confirmation)
  end

  # Confirm current user
  # Admin bypass to allow edit / update user
  def correct_user
    @user = Author.find(params[:id])
    unless is_admin?
      redirect_to(root_url) unless current_user?(@user)
    end
  end
end
