class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].nil?
      render json: {error: "Please provide a location."}, status: 400
    else
      coordinates = MapquestFacade.fetch_lat_lng(params[:location])
      forecast = ForecastFacade.fetch_forecast(coordinates)
      render json: ForecastSerializer.new(forecast)
    end
  end
end