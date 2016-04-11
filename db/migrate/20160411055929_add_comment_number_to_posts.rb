class AddCommentNumberToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comment_number, :integer, :default => 0
  end
end
