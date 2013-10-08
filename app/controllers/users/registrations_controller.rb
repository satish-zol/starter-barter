class Users::RegistrationsController < Devise::RegistrationsController
  #before_filter :search_content
  # def edit
    # @user = current_user
  # end  
  # def update
    # @user = User.find(current_user)
    # #debugger
    # if @user.update_attributes(params[:user])
      # sign_in @user, :bypass => true
      # redirect_to :back
    # else
      # render "edit"
    # end
  # end


  def create
    if session[:omniauth] == nil #OmniAuth
      if verify_recaptcha
        super
        session[:omniauth] = nil unless @user.new_record? #OmniAuth
      else
        build_resource
         clean_up_passwords(resource)
        flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
         flash.delete :recaptcha_error
        render_with_scope :new
      end
     else
       super
       session[:omniauth] = nil unless @user.new_record?
    end
  end   
end