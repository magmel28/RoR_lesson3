class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :post_id
      t.string :integer
      t.string :user_id
      t.string :integer

      t.timestamps null: false
    end
  end
end
