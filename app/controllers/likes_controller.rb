class LikesController < ApplicationController

  def like
    @post = Post.find(params[:post_id])
    if like_present?
      Like.destroy(find_like)
    end
    if params[:like_post].present?
      create_like
    else
      create_dislike
    end

  end

  def dislike
    @post = Post.find(params[:post_id])

    @dislike_presence = Like.where(post_id: @post.id, user_id: current_user.id, dislike_post: true).exists?
    unless @dislike_presence
      Like.create(post_id: @post.id, user_id: current_user.id, dislike_post: true)
    end


  end



  def find_like
    Like.where(post_id: @post.id, user_id: current_user.id)
  end

  def like_present?
    Like.where(post_id: @post.id, user_id: current_user.id).present?
  end

  def create_like
    Like.create(post_id: @post.id, user_id: current_user.id, like_post: true)
  end

  def create_dislike
    Like.create(post_id: @post.id, user_id: current_user.id, dislike_post: true)
  end

end
