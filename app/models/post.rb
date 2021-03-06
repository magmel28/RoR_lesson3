class Post < ActiveRecord::Base
  acts_as_taggable

  validates_presence_of :title, :body, :user_id
  validates :title,
            length: { minimum: 5, maximum: 140 },
            uniqueness: true
  validates :body, length: { minimum: 140 }

  belongs_to  :user
  has_many    :comments, dependent: :destroy
  has_many    :likes, dependent: :destroy

  scope :newest, -> { order('created_at')  }
end
