class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.integer :category_id
      t.integer :subcategory_id

      t.timestamps
    end
  end
end
