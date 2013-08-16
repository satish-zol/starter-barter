class AddInReturnToAppliedjobs < ActiveRecord::Migration
  def change
  	add_column :appliedjobs, :in_return, :text
  end
end
