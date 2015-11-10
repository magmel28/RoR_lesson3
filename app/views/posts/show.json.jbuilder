json.extract! @post, :id, :title, :body, :tags, :created_at
json.user_name @post.user.name
