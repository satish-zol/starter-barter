  namespace :db do

  desc "load subcategories data from csv"
  task :subcategories  => :environment do
    require 'csv'

    CSV.foreach("#{Rails.root}/lib/tasks/subcategory.csv", {:headers => true}) do |row|
      co = Subcategory.create(:name => row[1], :category_id => row[2])
      puts "#{co.name} created."
    end
  end
end