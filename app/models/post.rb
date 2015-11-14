class Post < ActiveRecord::Base
  validates_presence_of :title, :body, :user_id
  validates :title,
            length: { minimum: 5, maximum: 140 },
            uniqueness: true
  validates :body, length: { minimum: 140 }

  belongs_to  :user
  has_many    :comments

  scope :newest, -> { order('created_at')  }
end
