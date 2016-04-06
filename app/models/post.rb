class Post < ActiveRecord::Base

  belongs_to :user
  has_many :attendees
  has_many :comments
  belongs_to :category
  validates_presence_of :name

  has_many :post_groupships
  has_many :groups, :through => :post_groupships

  def post_count!
    self.post_count ||= 0
    self.post_count += 1
    self.save
  end
end
