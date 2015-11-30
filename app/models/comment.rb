class Comment < ActiveRecord::Base
  validates :body,
            length: { minimum: 1, maximum: 500 },
            presence: true

  belongs_to :post
  belongs_to :user

  has_ancestry
end
