class AddJobStatusToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :job_status, :string
  end
end
