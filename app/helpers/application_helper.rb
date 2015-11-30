module ApplicationHelper
  def comment_time comment
    Time.now - comment.created_at
  end
end
