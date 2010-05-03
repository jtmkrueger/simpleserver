class SitesController < ApplicationController
  before_filter :authenticate
  
  def index
    @sites = Site.all
  end
  
  def show
    @site = Site.find(params[:id])
  end
  
  def new
    @host = hosts.find(params[:host_id])
    @site = Site.new
  end
  
  def create
    @host = Host.find(params[:host_id])
    @site = @host.sites.new(params[:site])
    if @site.save
      flash[:notice] = "Successfully created site."
      redirect_to host_path(@host)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @host = Host.find(params[:host_id])
    @site = Site.find(params[:id])
  end
  
  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(params[:site])
      flash[:notice] = "Successfully updated site."
      redirect_to edit_host_site_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    flash[:notice] = "Successfully destroyed site."
    redirect_to host_path(@host)
  end
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME && password == PASSWORD
    end
  end
end
