class AddRatingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :raiting, :integer, default: 1
  end
end
