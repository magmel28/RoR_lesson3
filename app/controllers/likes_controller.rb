class LikesController < ApplicationController
#before_action :current_user_present?, only: :vote
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
    Like.where(like_set_params).present?
  end

  def dislike_present?
    Like.where(dislike_set_params).present?
  end

  def create_like
    Like.create(like_set_params)
  end

  def create_dislike
    Like.create(dislike_set_params)
  end

  def params_like_present?
    params[:like_post].present?
  end

  def params_dislike_present?
    params[:dislike_post].present?
  end

  def check_user_post post
    post.user_id == session[:user_id] ? true : false
  end

  def like_set_params
    {post_id: @post.id, user_id: session[:user_id], like_post: true}
  end

  def dislike_set_params
    {post_id: @post.id, user_id: session[:user_id], dislike_post: true}
  end


  private
  def current_user_present?
    if session[:user_id].nil?
      redirect_to root_path
    end
  end

end
