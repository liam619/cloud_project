class LikebooksController < ApplicationController

  def new

    book = Book.find(params[:id])
    meta = {book_id: params[:id]}

    if(LikeBook.exists?(meta))
      LikeBook.where(meta).first.increment!(:like_count)
    else
      LikeBook.create(meta)
    end

    flash[:success] = "Thank you for liking  #{book.name}."

    redirect_back(fallback_location: root_path)
  end
end
