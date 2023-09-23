require "rails_helper"

RSpec.describe ForecastService do
  describe "forecast service", :vcr do
    it "returns forecast json" do
      response = ForecastService.get_forecast("29.671210,-82.307720")
      expect(response).to be_a(Hash)
      expect(response).to have_key(:location)
      expect(response[:location]).to be_a(Hash)
      expect(response).to have_key(:current)
      expect(response[:current]).to be_a(Hash)
      expect(response).to have_key(:forecast)
      expect(response[:forecast]).to be_a(Hash)
      expect(response[:forecast]).to have_key(:forecastday)
      expect(response[:forecast][:forecastday]).to be_an(Array)
      expect(response[:forecast][:forecastday].first).to have_key(:hour)
      expect(response[:forecast][:forecastday].first[:hour]).to be_an(Array)
    end
  end
end