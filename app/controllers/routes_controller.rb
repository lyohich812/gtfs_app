class RoutesController < ApplicationController
before_action :show, except: [:index]
RealtimeJob.perform_later
  def index
    #kak to nado zamutit lishnie routes bez trips ubrat UPD: zamutil    
    @routes = Route.where(route_id: Trip.distinct.pluck(:route_id)).paginate(page: params[:page])       
  end

  def show
    @route = Route.find_by(id: params[:id])    
    @trip = Trip.where(route_id: @route.route_id).pluck(:route_id, :trip_id, :shape_id)
    #forward
    @shape = Shape.where(shape_id: @trip[0][2])
    #reverse
    @shapeBack = Shape.where(shape_id: @trip[1][2])

    @shapeArr = []
    @shape.each do |shape|
      @shapeArr.push([shape.shape_pt_lat.to_f, shape.shape_pt_lon.to_f])
    end

    @shapeBackArr = []
    @shapeBack.each do |shape|
      @shapeBackArr.push([shape.shape_pt_lat.to_f, shape.shape_pt_lon.to_f])
    end
  
    # stops ids here
    @stoptime = StopTime.where(trip_id: @trip[0][1]).distinct.pluck(:stop_id)   
    @stoptimeBack = StopTime.where(trip_id: @trip[1][1]).distinct.pluck(:stop_id)
    

    #stops here
    @stops = Stop.where(stop_id: @stoptime)
    @stopsBack = Stop.where(stop_id: @stoptimeBack)

    # finally stop coordinates and names here
    @stopCords = []
    @stops.each do |stop|
      @stopCords.push([stop.stop_lat.to_f, stop.stop_lon.to_f])
    end

    @stopNames = @stops.pluck(:stop_name)
    
    @stopCordsBack = []
    @stopsBack.each do |stop|
      @stopCordsBack.push([stop.stop_lat.to_f, stop.stop_lon.to_f])
    end

    @stopNamesBack = @stopsBack.pluck(:stop_name)
  end
end