class JobsController < ApplicationController
  before_filter :authenticate_user!
  # GET /jobs
  # GET /jobs.json
  def index
    #debugger
    @jobs = Job.all
    @job = Job.where('user_id = ?', current_user.id) if current_user.present?    
    #@categories = Category.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  def people_applied_for_job
    @users = User.applied_job_user(params[:job])
  end

  def select_subcategory
    #debugger 
    #@job = Job.new 
    @subcategories = Subcategory.where(:category_id=>params[:id]).order(:name) unless params[:id].blank?
    render :partial => "subcategory", :locals => { :subcategories => @subcategories } 
  end 
  # GET /jobs/1
  # GET /jobs/1.json
  def show
    
    @job = Job.find(params[:id])
    @applied_job_count=Appliedjobs.find_all_by_job_id(params[:id]).count
    @users = User.applied_job_user(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
      #redirect_to :back
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    #debugger
    @job = Job.new
    @subcategory = Subcategory.all
    #@subcategories = Subcategory.where(:category_id=>params[:id]).order(:name) unless params[:id].blank?
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
    #redirect_to "/jobs/"
  end

  # GET /jobs/1/edit
  def edit
    #debugger
    @job = Job.find(params[:id])
    @edit_subcat = Subcategory.where('id = ?', @job.subcategory_id)
    #@subcategories = Subcategory.where(:category_id=>@job.subcategory_id).order(:name) unless params[:id].blank?
    @subcategory = Subcategory.all 
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(params[:job])
   
    respond_to do |format|
      if @job.save
        format.html { redirect_to "/jobs/", notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to "/jobs/", notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end
end
