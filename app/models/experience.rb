class Experience < ActiveRecord::Base
  attr_accessible :company_name, :description, :end_date, :is_current, :location, :start_date, :title, :user_id
  belongs_to :user
  
  validates :user_id, presence: true
end
