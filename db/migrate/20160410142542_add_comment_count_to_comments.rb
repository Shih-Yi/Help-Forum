class AddCommentCountToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_count, :integer, :default => 0
  end
end
