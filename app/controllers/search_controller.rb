class SearchController < ApplicationController

  def search
   	@q = Skill.search(params[:q])	
  	@search_results = @q.result(:distinct => true) 
  end	
end
