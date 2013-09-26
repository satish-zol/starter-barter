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

  def inbox_count(current_user)
    @unread_messages = Message.where("receiver_id = ? AND read_at IS NULL", current_user.id).count
  end

end

