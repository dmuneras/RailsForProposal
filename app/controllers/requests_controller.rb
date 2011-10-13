class RequestsController < ApplicationController
  
  before_filter :logged_in?, :except => [:index]
  before_filter :is_admin?, :only => [:new, :edit, :create, :destroy] 
  
  def index
    @requests = Request.all
  end

  def show
    @request = Request.find(params[:id])
    session[:last_request] = Request.find(params[:id])
  end

  def new
    @request = Request.new
    @types = []
    for rq_type in RequestType.all do
      @types << rq_type
    end
  end

  def create
    @request = Request.new(params[:request])
    if @request.save
      redirect_to @request, :notice => "RFP creado exitosamente."
    else
      render :action => 'new'
    end
  end

  def edit
    @request = Request.find(params[:id])
    @types = []
    for rq_type in RequestType.all do
      @types << rq_type
    end
  end

  def update
    @request = Request.find(params[:id])
    if @request.update_attributes(params[:request])
      redirect_to @request, :notice  => "RFP actualizado exitosamente."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to requests_url, :notice => "RFP eliminado exitosamente."
  end

  def statistics
    @statistics = Request.average_per_type
  end
end
