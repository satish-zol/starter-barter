class ApplicationController < ActionController::Base
  protect_from_forgery 
  include ApplicationHelper
  before_filter :search_content

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private
  def search_content
  	@q = Skill.search(params[:q])
    @search_results = @q.result(:distinct => true) 
  end

end
