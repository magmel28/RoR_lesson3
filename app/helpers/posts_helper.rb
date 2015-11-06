module PostsHelper
  def check_user_post
    true if @post.user.id = current_user.id
  end
end
