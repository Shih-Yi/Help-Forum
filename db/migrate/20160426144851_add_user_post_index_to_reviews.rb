class AddUserPostIndexToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :post, index: true
    add_reference :reviews, :user, index: true
  end
end
