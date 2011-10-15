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
      redirect_to root_url, :notice => "Tipo de RFP creado exitosamente."
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
      redirect_to root_url, :notice  => "Tipo de RFP actualizado exitosamente."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @request_type = RequestType.find(params[:id])
    @request_type.destroy
    redirect_to root_url, :notice => "Tipo de RFP eliminado."
  end
end
