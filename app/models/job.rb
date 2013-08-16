class Job < ActiveRecord::Base
  attr_accessible :category_id, :description, :subcategory_id, :title, :user_id, :in_return
  belongs_to :user
  belongs_to :appliedjobs
  #has_many :appliedjobs
  #has_many :appliedjobs, :through => :user
end
