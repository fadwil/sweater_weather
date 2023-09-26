require "rails_helper"

RSpec.describe "/api/v1/forecast", type: :request do
  describe "#index", :vcr do
    it "returns a forecast type json object" do
      get "/api/v1/forecast?location=Gainesville,FL"
      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_a(Hash)
      expect(data[:data].keys).to eq([:id, :type, :attributes])

      expect(data[:data][:id]).to eq(nil)
      expect(data[:data][:type]).to eq("forecast")
      expect(data[:data][:attributes]).to be_a(Hash)
      expect(data[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
      
      expect(data[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(data[:data][:attributes][:current_weather].keys).to eq([:last_updated,
                                                                      :temperature,
                                                                      :feels_like,
                                                                      :humidity,
                                                                      :uvi,
                                                                      :visibility,
                                                                      :condition,
                                                                      :icon
                                                                      ])

      expect(data[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(data[:data][:attributes][:daily_weather].first.keys).to eq([:date,
                                                                    :sunrise,
                                                                    :sunset,
                                                                    :max_temp,
                                                                    :min_temp,
                                                                    :condition,
                                                                    :icon])
      expect(data[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(data[:data][:attributes][:hourly_weather].first.keys).to eq([:time,
                                                                    :temperature,
                                                                    :conditions,
                                                                    :icon])
    end
  end
end