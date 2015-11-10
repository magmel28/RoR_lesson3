json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :tags
  json.user_name post.user.name
  json.url post_url(post, format: :json)
end
