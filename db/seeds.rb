# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 
	@jobs = Job.all
	@jobs.each do |update_job|
		update_job.update_attributes(:job_status => "Open")
		puts "Job status updated"
	end
    