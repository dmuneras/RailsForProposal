class RequestTypesController < ApplicationController
  def index
    @request_types = RequestType.all
  end

  def show
    @request_type = RequestType.find(params[:id])
  end

  def new
    @request_type = RequestType.new
  end

  def create
    @request_type = RequestType.new(params[:request_type])
    if @request_type.save
      redirect_to @request_type, :notice => "Successfully created request type."
    else
      render :action => 'new'
    end
  end

  def edit
    @request_type = RequestType.find(params[:id])
  end

  def update
    @request_type = RequestType.find(params[:id])
    if @request_type.update_attributes(params[:request_type])
      redirect_to @request_type, :notice  => "Successfully updated request type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @request_type = RequestType.find(params[:id])
    @request_type.destroy
    redirect_to request_types_url, :notice => "Successfully destroyed request type."
  end
end
