class AppliedjobsController < ApplicationController
  # Method for saving jo and user ids when current user apply for job.
  def applied_to_job
  	
    @applied_to_job = Appliedjobs.new(:job_id => params[:job_id],
  	 :user_id => current_user.id, :apply_status => true, :in_return => params[:appliedjobs][:in_return])

    if @applied_to_job.save
      redirect_to :back, notice: 'You applied for this job successfully.'
	end
  
  end	

end
