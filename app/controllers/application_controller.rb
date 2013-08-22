class ApplicationController < ActionController::Base
  protect_from_forgery 
  include ApplicationHelper
  before_filter :search_content
  helper_method :is_applied?, :is_accepted?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def is_applied?(job)
    #debugger
    applied_jobs = Appliedjobs.where("job_id=? and user_id=?", job.id, current_user.id)
    return true if applied_jobs.present?

  end

  def is_accepted?(job)
    accepted_jobs = UsersJobs.where("job_id=?", job.id )
    return true if accepted_jobs.present?  
  end

  private
  def search_content
  	@q = Skill.search(params[:q])
    @search_results = @q.result(:distinct => true) 
  end

end
