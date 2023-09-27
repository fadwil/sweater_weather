class Api::V1::RoadTripController < ApplicationController
  def create
    begin
      validation
      trip = RoadTripFacade.create_road_trip(params[:road_trip][:origin], params[:road_trip][:destination])
      render json: RoadTripSerializer.new(trip),status: 200
    rescue StandardError => e
      render json: { error: "Invalid credentials" }, status: 401
    end
  end

  private

  def validation
    user = User.find_by(api_key: params[:api_key])
    raise "Invalid credentials" if user.nil? || user.api_key != params[:api_key]
    user
  end
end