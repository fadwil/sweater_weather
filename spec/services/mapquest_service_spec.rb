require "rails_helper"

RSpec.describe MapquestService do
  describe "mapquest service", :vcr do
    it "returns lat lon" do
      response = MapquestService.get_lat_lng("Gainesville,FL")
      expect(response).to be_a(Hash)
      expect(response[:results]).to be_an(Array)
      expect(response[:results][0]).to be_a(Hash)
      expect(response[:results][0][:locations]).to be_an(Array)
      expect(response[:results][0][:locations][0]).to have_key(:latLng)
      expect(response[:results][0][:locations][0][:latLng]).to be_a(Hash)
    end
  end
end