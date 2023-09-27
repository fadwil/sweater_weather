require "rails_helper"

RSpec.describe RoadTripFacade do
  describe ".create_road_trip", :vcr do
    context "when a valid route is found" do
      it "creates a road trip object" do
        origin = "Denver,CO"
        destination = "Boulder,CO"

        road_trip = RoadTripFacade.create_road_trip(origin, destination)
        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to be_a(String)
        expect(road_trip.end_city).to be_a(String)
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.weather_at_eta).to be_a(Hash) 
      end
    end

    context "when a route is not found" do
      it "raises a RouteError" do
        origin = "Denver,CO"
        destination = "London,UK"
        bad_trip = RoadTripFacade.create_road_trip(origin, destination)
        expect(bad_trip.travel_time).to eq("impossible")
      end
    end
  end
end
