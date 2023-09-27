require "rails_helper"

RSpec.describe RoadTrip do
  let(:road_trip) {
    {
      start_city: "Denver, CO",
      end_city: "Boulder, CO",
      travel_time: "00:31:33",
      weather_at_eta: 
      {
        datetime: "2023-09-26 15:27:31",
        temperature: 69.8,
        condition: "Sunny"
      }
    }
  }
  it "exists and has attributes" do
    colorado_trip = RoadTrip.new(road_trip)

    expect(colorado_trip).to be_a(RoadTrip)
    expect(colorado_trip.id).to eq(nil)
    expect(colorado_trip.start_city).to eq("Denver, CO")
    expect(colorado_trip.end_city).to eq("Boulder, CO")
    expect(colorado_trip.travel_time).to eq("00:31:33")
    expect(colorado_trip.weather_at_eta).to be_a(Hash)
    expect(colorado_trip.weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
    expect(colorado_trip.weather_at_eta[:datetime]).to eq("2023-09-26 15:27:31")
    expect(colorado_trip.weather_at_eta[:temperature]).to eq(69.8)
    expect(colorado_trip.weather_at_eta[:condition]).to eq("Sunny")
  end
end