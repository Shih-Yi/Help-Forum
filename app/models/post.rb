class Post < ActiveRecord::Base

  belongs_to :user
  has_many :attendees
  has_many :comments
  belongs_to :category
  validates_presence_of :name
end
