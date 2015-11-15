module LikesHelper
  def user_like_present?
    Like.where(post_id: @post.id, user_id: current_user.id).exists?
  end
end
