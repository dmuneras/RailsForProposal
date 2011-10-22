class RequestsController < ApplicationController
  
  before_filter :logged_in?, :except => [:index]
  before_filter :is_admin?, :only => [:new, :edit, :create, :destroy] 
  
  def index
    @requests = Request.all
  end

  def show
    @request = Request.find(params[:id])
    @comments = @request.comments
    session[:last_request] = Request.find(params[:id])
  end

  def new
    @request = Request.new
    @types = RequestType.all 
  end

  def create
     @types =  RequestType.all 
    @request = Request.new(params[:request])
    if @request.save
      redirect_to @request, :notice => "RFP creado exitosamente."
    else
      render :action => 'new'
    end
  end

  def edit
    @request = Request.find(params[:id])
    @types = RequestType.all
  end

  def update
    @request = Request.find(params[:id])
    if @request.update_attributes(params[:request])
      redirect_to @request, :notice  => "RFP actualizado exitosamente."
    else
      render :action => 'edit', :notice => "No se pudo actualizar"
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to requests_url, :notice => "RFP eliminado exitosamente."
  end

  def statistics

    #TYPE STATISTICS
    @statistics = Request.statistics_per_type 
    pievalues = []
    for data in Request.rfps_per_type do 
      pievalues <<  PieValue.new(data["total"], data["name"])
    end
    @graph =  graph_code pievalues
    
    #USER STATISTICS
    @statistics_user = User.statistics_per_user
  end

  def graph_code values
    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object( 600, 300, url_for( :action => 'statistics', :format => :json ) )
      }
      wants.json { 
        title = Title.new("Grafico estadistico")
        chart = OpenFlashChart.new( title ) do |c|
          c <<  Pie.new( :values => values, :animate => true, :colours => ["D90037", "#0037D9", "#000"])
          c.set_bg_colour('#FFFFFF')
          c.set_title = title
        end
        render :text => chart, :layout => false
      }
    end
  end
  
end
