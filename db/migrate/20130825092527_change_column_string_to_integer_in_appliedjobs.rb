class ChangeColumnStringToIntegerInAppliedjobs < ActiveRecord::Migration
  def up
  	remove_column :appliedjobs, :job_id
  	remove_column :appliedjobs, :user_id
  	add_column :appliedjobs, :job_id, :integer
  	add_column :appliedjobs, :user_id, :integer
  end

  def down
  	remove_column :appliedjobs, :job_id
  	remove_column :appliedjobs, :user_id
  	add_column :appliedjobs, :job_id, :string
  	add_column :appliedjobs, :user_id, :string
  end
end
