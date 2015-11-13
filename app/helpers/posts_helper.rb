module PostsHelper
  def check_user_post
    true if @post.user.id == current_user.id
  end

  def check_user_comment(comment)
    true if comment[:user_id] == session[:user_id]
  end

  def comments_count post
    if post.comments.count == 1
      post.comments.count.to_s + ' comment'
    else
      post.comments.count.to_s + ' comments'
    end
  end

end
