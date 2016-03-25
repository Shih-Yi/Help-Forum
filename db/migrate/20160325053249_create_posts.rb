class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :description
      t.boolean :is_public

      t.timestamps null: false
    end
  end
end
