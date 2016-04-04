class Group < ActiveRecord::Base
  has_many :post_groupships
  has_many :posts, :through => :post_groupships
end
