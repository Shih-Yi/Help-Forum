class AddPostCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_count, :integer
  end
end
