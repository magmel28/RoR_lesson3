class LikesController < ApplicationController
before_action :current_user_present?, only: :vote
  def vote
    @post = Post.find(params[:post_id])
    if like_present?
      if params_like_present?
        Like.destroy(find_vote)
      elsif params_dislike_present?
        Like.destroy(find_vote)
        create_dislike
      end
    elsif dislike_present?
      if params_dislike_present?
        Like.destroy(find_vote)
      elsif params_like_present?
        Like.destroy(find_vote)
        create_like
      end
    else
      if params_like_present?
        create_like
      elsif params_dislike_present?
        create_dislike
      end
    end
  end

  def find_vote
    Like.where(post_id: @post.id, user_id: current_user.id)
  end

  def like_present?
    Like.where(post_id: @post.id, user_id: current_user.id, like_post: true).present?
  end

  def dislike_present?
    Like.where(post_id: @post.id, user_id: current_user.id, dislike_post: true).present?
  end

  def create_like
    Like.create(post_id: @post.id, user_id: current_user.id, like_post: true)
  end

  def create_dislike
    Like.create(post_id: @post.id, user_id: current_user.id, dislike_post: true)
  end

  def params_like_present?
    params[:like_post].present?
  end

  def params_dislike_present?
    params[:dislike_post].present?
  end

  def params_like
    
  end

  private
  def current_user_present?
    if session[:user_id].nil?
      return
    end
  end

end
