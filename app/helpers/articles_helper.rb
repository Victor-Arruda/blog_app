module ArticlesHelper
  def persisteds_comments(comments)
    comments.reject{ |comment| comment.new_record? }
  end
end
