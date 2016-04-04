class CreatePostGroupships < ActiveRecord::Migration
  def change
    create_table :post_groupships do |t|
      t.integer :post_id
      t.integer :group_id

      t.timestamps null: false
    end
    add_index :post_groupships, :post_id
    add_index :post_groupships, :group_id
  end
end
