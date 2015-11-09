class Post < ActiveRecord::Base
  validates_presence_of :title, :body, :user_id
  validates :title,
            length: {minimum: 5, maximum: 100},
            uniqueness: true

  belongs_to :user

end
