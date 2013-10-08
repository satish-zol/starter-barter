class CreateAppliedjobs < ActiveRecord::Migration
  def change
    create_table :appliedjobs do |t|
      t.string :job_id
      t.string :user_id
      t.boolean :apply_status	
      t.timestamps
    end
  end
end
