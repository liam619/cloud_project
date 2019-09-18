class BooksController < ApplicationController
  before_action :course_owner, only: [:edit, :update]
  before_action :logged_in_admin, only: [:destroy]

  def show
    @book = Book.find(params[:id])
    @hide_for_show = true
  end

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    new_book = book_params

    # Set book created by current user
    new_book[:user_id] = current_user.id

    # Perform validation in another method
    validate_param(new_book)

    @book = Book.new(new_book)

    if !@book.errors.any? && @book.validate
      @book.save
      flash[:success] = "#{@book.name} created."
      redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    update_course = book_params

    validate_param(update_book)

    if @book.update_attributes(update_book)
      flash[:success] = "#{@book.name} successful updated."
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id]).destroy
    flash[:success] = "#{book.name} removed."
    redirect_to books_path
  end

  # def reset
  #   book = Book.find(params[:id])
  #
  #   if book.like_courses.count > 0 || book.dislike_courses.count > 0
  #     book.like_courses.each do |like|
  #       like.destroy
  #     end
  #
  #     course.dislike_courses.each do |dislike|
  #       dislike.destroy
  #     end
  #
  #     flash[:success] = "#{course.name} rating reset to 0."
  #     redirect_back(fallback_location: root_path)
  #   else
  #     flash[:danger] = "#{course.name}, nobody have opinions on this course yet."
  #     redirect_back(fallback_location: root_path)
  #   end
  # end

  private

  def book_params
    params.require(:book).permit(:name, :description, :image, :categories => [], :distributors => [])
  end

  # Replace the params (ids) with hash value
  def validate_param(params)
    # Convert ids to Hash
    if params[:distributors].present?
      params[:distributors].collect! {|l| Distributor.find(l)}
    end

    if params[:categories].present?
      params[:categories].collect! {|c| Category.find(c)}
    end

    # if params[:prerequisites].present?
    #   params[:prerequisites].collect! {|p| Prerequisite.where(id: p).first_or_initialize} # New prerequisite if not found
    # end
  end

  # Ensure non course owner unable to edit the course that not belong to them
  # Admin bypass and allow to edit / update course
  def course_owner
    @book = Book.find(params[:id])
    user = Author.find(@book.user_id)

    unless is_admin?
      if !current_user?(user)
        flash[:danger] = "You are not authorized to edit this book."
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
