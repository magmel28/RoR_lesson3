class AddLikePostAndDislikePostToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :like_post, :boolean, default: false
    add_column :likes, :dislike_post, :boolean, default: false
  end
end
