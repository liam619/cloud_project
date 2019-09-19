module ApplicationHelper
  def full_title(page_title = '')
    base_title = "YourBook"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # For nav tab, active the correct tab
  def is_active?(link_path)
    link_path.include?(request.path) ? "active" : ""
  end

  def do_count(vote, id)

    meta = {book_id: id}
    value = "0"

    if vote.eql? "like"
      if LikeBook.exists?(meta)
        value = LikeBook.where(meta).pluck("like_count").first
      end
    else
      if DislikeBook.exists?(meta)
        value = DislikeBook.where(meta).pluck("dislike_count").first
      end
    end

    value
  end
end