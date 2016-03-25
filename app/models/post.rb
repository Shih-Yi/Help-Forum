class Post < ActiveRecord::Base
  has_many :attendees
  has_many :comments
  validates_presence_of :name
end
