class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :onLoad

  # on load main page, for the header drop down box
  def onLoad
    @categories = Category.all.order(name: :asc)

    @distributors = Distributor.all.order(name: :asc)

    @books = Book.order(name: :asc)
  end

  private

  # Check user is logged in otherwise redirect to login page
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please proceed to log in."
      redirect_to login_path
    end
  end

  # Check user is admin otherwise redirect to root page
  def logged_in_admin
    unless is_admin?
      flash[:danger] = "Restricted page. Admin access only."
      redirect_to root_url
    end
  end

  # Check user is registered otherwise redirect to root
  def non_user
    if logged_in?
      flash[:danger] = "Sorry, you already a registered user."
      redirect_to root_url
    end
  end
end