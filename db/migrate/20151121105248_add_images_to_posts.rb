class AddImagesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_image_url, :string
  end
end
