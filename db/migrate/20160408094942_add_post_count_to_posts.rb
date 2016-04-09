class AddPostCountToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :post_count
    add_column :posts, :post_count, :integer, :default => 0
  end
end
