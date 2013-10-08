class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  #before_filter :search_content
  #load_and_authorize_resource
  def index
    
    @users = User.all
    @skills = Skill.all
    @experiences = Experience.all
    @educations = Education.all
    @job = Job.where('user_id = ?', current_user.id).order("created_at DESC").paginate(:page => params[:page], :per_page => 10) if current_user.present?
    user = current_user
     
    #if params[:content_select] == "0"
      
    # @q = Job.search(params[:q])
    # @search_results = @q.result(:distinct => true).order("created_at DESC")
    #end
   
    show_recomm(user)
   
  end

  def user_profile
    @users = User.all
    # @skills = Skill.all
    # @experiences = Experience.all
    # @educations = Education.all
    user = current_user
    # @q = User.search(params[:q])
    # @search_results = @q.result(:distinct => true)
    # @j = Job.search(params[:j], :search_key => :j)
    # @job_search = @j.result(:distinct => true)
    show_recomm(user)
    respond_to do |format|
      format.html
    end 
  end 

  def search
    #debugger
    if params[:search][:content_select] == "0"
      @job_search = Job.where(['title LIKE ? AND user_id != ?', "%#{params[:search][:content]}%", current_user.id]).paginate(:page => params[:page], :per_page => 10)
    end

    if params[:search][:content_select] == "1"
      # @q = User.search(params[:q])
      @user_search = User.where(['username LIKE ?', "%#{params[:search][:content]}%"]).paginate(:page => params[:page], :per_page => 10)
      # @search_results = @q.result(:distinct => true).order("created_at DESC")
    end  
    if params[:search][:content_select] == "2"
      @my_job = Job.where('user_id = ?', current_user.id).paginate(:page => params[:page], :per_page => 10)
      # @q = @job.search(params[:q])
      # @search_results = @q.result(:distinct => true).order("created_at DESC")
    end
    
    # @result_arr = []

    # @search_results.each do |user|
    #    @result_arr << user
    # end
    
    respond_to do |format|
      format.html
    end 
  end

  def job_search
    
    index
    @job_result_arr = []

    @job_search.each do |job|
       @job_result_arr << job
    end
    
    respond_to do |format|
      format.html
    end 
  end

  def new_profile
    @profile = current_user.profile
  end

  def profile
    @user = current_user
    @profile = current_user.profile
    #debugger
    if @profile.present? && params[:profile] != nil
       @user.profile.update_attributes(params[:profile])
        flash[:notice] = "Profile saved successfully."
        redirect_to "/"
      else
        flash[:error] = "Something went wrong."
        redirect_to :action => "index"
      end
    
  end

  def profile_pic_upload
    #debugger
    #@pic = currparams["profile_pic_upload"]["profile_picture"])
    if current_user.update_attributes(params["profile_pic_upload"]["profile_picture"])
        flash[:notice] = "Profile picture saved successfully."
        redirect_to "/"
      else
        flash[:error] = "Something went wrong."
        redirect_to :back
      end
  end

  def show_profile
    index
    # @show_recomm = []
    # @users = User.all
    @user = User.find(params[:id])
    show_recomm(current_user)#@users_recomm = User.where("iam=?", "#{current_user.iamlookingfor}")
    #debugger
    # @users.each do |reco_user|
    #   #debugger
    #   Similus.add_activity([reco_user.username.to_s, reco_user.id], :show_profile,
    #    [reco_user.iam.to_s])
    # end
    
    # @show_recomm = Similus.similar_to([@user.iamlookingfor.to_s])

    #@show_recomm.select { |x| x[:score] == 2.0 }  
    # @users_recomm = User.where("iam=?", "#{@user.iamlookingfor}")
    # Similus.add_activity(@user, :show_profile, @users_recomm)
  end

  def show_recomm(user)
    @users_recomm = User.where("iam=?", "#{user.iamlookingfor}") unless user.blank?
  end

  def add_experience
    @experience = current_user.experiences.new(params[:experience])
    @experience.save
    respond_to do |format|
      format.js
    end
  end
  
  def add_skill
    #debugger
    @skill = current_user.skills.new(params[:skill])
    @skill.save
    respond_to do |format|
      format.js
    end
  end
  
  def add_education
    @education = current_user.educations.new(params[:education])
    @education.save
    respond_to do |format|
      format.js
    end
  end

  def edit_user_info
    @user_fname_lname = current_user
    @profile = current_user.profile
  end

  def edit_skill
    
    @skill = current_user.skills.find(params[:id])
    @id = @skill.id
    @proficiency = @skill.proficiency
    # respond_to do |format|
    #   format.js
    # end
    
  end
  
  def update_user_info
    #debugger

    if params[:user]
      #debugger
      @user_profile = current_user.update_attributes(params[:user])
    end  
    if params[:profile]
      @profile_overview = current_user.profile.update_attributes(params[:profile])
    end
    
    if params[:skill] && params[:skill_id]
      @skill = current_user.skills.find(params[:skill_id])
       #@skill.update_attributes(:name => params[:skill][:name], :proficiency => params[:skill][:proficiency])
       @skill.update_attributes(params[:skill])
    end
        
    if params[:experience] && params[:id]
      @experience = current_user.experiences.find(params[:id])
      @experience.update_attributes(params[:experience]) 
    end
    
    if params[:education] && params[:id]
      @education = current_user.educations.find(params[:id])
       @education.update_attributes(params[:education])
    end
    respond_to do |format|
      format.js
    end
    
  end

  def experience_delete
    @experience = current_user.experiences.find(params[:id])
    @experience.delete
     
    respond_to do |format|
      format.js
    end 
  end

  def skill_delete
    @skill = current_user.skills.find(params[:id])
    @skill.delete
     
    respond_to do |format|
      format.js
    end 
  end

  def education_delete
    @education = current_user.educations.find(params[:id])
    @education.delete
     
    respond_to do |format|
      format.js
    end 
  end
  
end
