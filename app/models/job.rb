class Job < ActiveRecord::Base
  attr_accessible :category_id, :description, :subcategory_id, :title, :user_id
  belongs_to :user
end
