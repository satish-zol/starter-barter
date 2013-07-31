module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def show_current_user?(user)
  	
  	@user = User.find(user) 
  	@user == current_user  	
  end


end

