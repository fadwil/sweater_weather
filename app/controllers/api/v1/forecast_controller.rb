class Api::V1::ForecastController < ApplicationController
  def index
    coordinates = MapquestFacade.fetch_lat_lng(params[:location])
    forecast = ForecastFacade.fetch_forecast(coordinates)
    render json: ForecastSerializer.new(forecast)
  end
end