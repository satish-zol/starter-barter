require 'will_paginate/array'
class JobsController < ApplicationController
  before_filter :authenticate_user!

  # GET /jobs
  # GET /jobs.json
  def index
    #debugger
    #@jobs = Job.order("created_at DESC")
    @jobs = Job.where(['user_id != ?', current_user.id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    #@job = Job.where('user_id = ?', current_user.id).order("created_at DESC") if current_user.present?    
    #@categories = Category.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  def people_applied_for_job
    @users = User.applied_job_user(params[:job])
  end

  def applied_jobs_by_current_user
    @applied_job = Job.job_applied_by_current_user(current_user.id)
  end

  # For showing the closed job applied by current user
  def closed_jobs_for_current_user
    #debugger
    @closed_jobs = Job.closed_job_for_current_user(current_user.id).sort_by{|j| j.created_at}.paginate(:page => params[:page], :per_page => 10)
  end

  # For Closing and Opening the job status
  def job_status
    
    if params[:status] == "Close"
      @job = Job.where(:id => params[:id])
      @job[0].update_attributes(:job_status => "Close")
    end
    if params[:status] == "Open"
      @job = Job.where(:id => params[:id])
      @job[0].update_attributes(:job_status => "Open")
    end
    redirect_to :back
  end

  #Method for declining the proposal who applied to job. 
  def cancel_the_proposal
    
    @job = Job.find(params[:message][:job_id])
    
    if @job.user_id == current_user.id
      @applied_job = Appliedjobs.find(:all, :conditions => ["user_id = ? and job_id = ? and apply_status = ?", params[:message][:user_id], params[:message][:job_id], true])
      @rejected_proposal = Message.new(:sender_id => current_user.id, :receiver_id => params[:message][:user_id], :job_id => params[:message][:job_id], :reason => params[:message][:reason])
    else
      @applied_job = Appliedjobs.find(:all, :conditions => ["user_id = ? and job_id = ? and apply_status = ?", current_user.id, params[:message][:job_id], true]) 
      @rejected_proposal = Message.new(:sender_id => current_user.id, :receiver_id => @job.user_id, :job_id => params[:message][:job_id], :reason => params[:message][:reason])
    end 
      @rejected_proposal.save
      
      @applied_job[0].update_attributes(:apply_status => false)
  end

  #Method for accepting and declining the proposal who posted job. 
  def accepted_proposal
    
    if params[:commit] == "Accept"
      @accepted_proposal = UsersJobs.new(:job_id => params[:job_id], :user_id => params[:user_id], :deal => true)
      @acceptance_message = Message.new(:sender_id => current_user.id, :receiver_id => params[:user_id], :job_id => params[:job_id], :reason => "Your proposal is accepted")

      if @accepted_proposal.save
        @delete_jobs = Appliedjobs.where(:job_id => params[:job_id])
        @acceptance_message.save
        @delete_jobs.each do |delete_job|
          delete_job.apply_status = true if params[:user_id] != delete_job.user_id
        end
        redirect_to :back, notice: 'You accept this proposal.'
      end
    end
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
    @applied_job_count = Appliedjobs.find_all_by_job_id(params[:id]).count
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
    @job.job_status = "Open"
    respond_to do |format|
      if @job.save
        format.html { redirect_to root_path, notice: 'Job was successfully created.' }
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
        format.html { redirect_to root_path, notice: 'Job was successfully updated.' }
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
      format.html { redirect_to root_path, notice: 'Job was successfully deleted.'  }
      format.json { head :no_content }
    end
  end
end
