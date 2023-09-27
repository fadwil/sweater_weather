require "rails_helper"

RSpec.describe "Roadtrip API", type: :request do
  describe "POST /api/v1/road_trip", :vcr do
    context "with valid input" do
      it "returns road trip information and weather data" do
        user = create(:user)

        road_trip_params = {
          origin: 'Cincinnati, OH',
          destination: 'Chicago, IL',
          api_key: user.api_key
        }

        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/road_trip', params: JSON.generate(road_trip_params), headers: headers
        
        expect(response).to have_http_status(200)

        road_trip_data = JSON.parse(response.body, symbolize_names: true)
        expect(road_trip_data).to be_a(Hash)
        expect(road_trip_data.keys).to eq([:data])
        expect(road_trip_data[:data]).to be_a(Hash)
        expect(road_trip_data[:data].keys).to eq([:id, :type, :attributes])
        expect(road_trip_data[:data][:id]).to eq(nil)
        expect(road_trip_data[:data][:type]).to eq("road_trip")
        expect(road_trip_data[:data][:attributes]).to be_a(Hash)
        expect(road_trip_data[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(road_trip_data[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(road_trip_data[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])
      end
    end

    context 'with missing or incorrect API key' do
      it 'returns 401 Unauthorized' do
        road_trip_params = {
          origin: 'Cincinnati, OH',
          destination: 'Chicago, IL',
          api_key: 'invalid_api_key'
        }

        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }

        post '/api/v1/road_trip', params: JSON.generate(road_trip_params), headers: headers

        expect(response).to have_http_status(401)
      end
    end
  end
end