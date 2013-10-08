  namespace :db do

  desc "load categories data from csv"
  task :categories  => :environment do
    require 'csv'

    CSV.foreach("#{Rails.root}/lib/tasks/categories.csv", {:headers => true}) do |row|
      co = Category.create(:name => row[1])
      puts "#{co.name} created."
    end
  end
end