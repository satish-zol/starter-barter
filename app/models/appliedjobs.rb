class Appliedjobs < ActiveRecord::Base
  attr_accessible :job_id, :user_id, :apply_status, :in_return
  has_many :jobs
  has_many :users, :through => :jobs 
end
