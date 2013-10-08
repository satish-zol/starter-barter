class Job < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  attr_accessible :category_id, :description, :subcategory_id, :title, :user_id, :in_return, :job_status
  belongs_to :user
  belongs_to :appliedjob

  has_many :messages
  #has_many :appliedjobs, :through => :user
  validates_presence_of :description, :title, :in_return, :category_id, :subcategory_id

  def self.job_applied_by_current_user(current_user_id)
    find_by_sql(["SELECT * FROM jobs j left join appliedjobs a on a.job_id = j.id and a.apply_status = true where a.user_id = #{current_user_id};"]) 
  end

  #Closed job for current user
  def self.closed_job_for_current_user(current_user_id)
    find_by_sql(["SELECT * FROM jobs j left join appliedjobs a on a.job_id = j.id and a.apply_status = true and j.job_status = 'Close' where a.user_id = #{current_user_id};"]) 
  end
end
