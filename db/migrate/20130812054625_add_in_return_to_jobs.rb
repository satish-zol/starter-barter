class AddInReturnToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :in_return, :text
  end
end
