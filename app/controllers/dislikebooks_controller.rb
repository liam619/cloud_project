class DislikebooksController < ApplicationController

  def new
    book = Book.find(params[:id])
    meta = {book_id: params[:id]}

    if(DislikeBook.exists?(meta))
      DislikeBook.where(meta).first.increment!(:dislike_count)
    else
      DislikeBook.create(meta)
    end

    flash[:success] = "Thank you for your feedback for  #{book.name}."

    redirect_back(fallback_location: root_path)
  end
end
