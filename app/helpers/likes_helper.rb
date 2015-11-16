module LikesHelper
  def user_like_present?
    Like.where(post_id: @post.id, user_id: current_user.id,  like_post: true).exists?
  end
  def user_dislike_present?
    Like.where(post_id: @post.id, user_id: current_user.id,  dislike_post: true).exists?
  end
end
