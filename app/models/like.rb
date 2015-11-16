class Like < ActiveRecord::Base
  validates_presence_of :post_id, :user_id

  belongs_to :post
  belongs_to :user

  scope :like_post, -> { where(like_post: true)  }
  scope :dislike_post, -> { where(dislike_post: true)  }
end
