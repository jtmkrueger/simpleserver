class ReportsController < ApplicationController
  def index
   
  end
  
  def show
    @report = Report.find(params[:id])
  end
  
  def new
    @report = Report.new
  end
  
  def create
    @report = Report.new(params[:report])
    if @report.save
      flash[:notice] = "Successfully created report."
      redirect_to @report
    else
      render :action => 'new'
    end
  end
  
  
  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(params[:report])
      flash[:notice] = "Successfully updated report."
      redirect_to @report
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    flash[:notice] = "Successfully destroyed report."
    redirect_to hosts_url
  end
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['USERNAME'] && password == ENV['PASSWORD']
    end
  end
end
