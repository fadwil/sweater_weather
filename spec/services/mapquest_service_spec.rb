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

    it "returns directions from mapquest api" do
      from = "Denver,CO"
      to = "Boulder,CO"

      directions = MapquestService.get_directions(from, to)

      expect(directions).to be_a(Hash)
      expect(directions[:route]).to be_a(Hash)
      expect(directions[:route]).to have_key(:formattedTime)
      expect(directions[:route][:formattedTime]).to be_a(String)
    end

    it "returns error if route can't be found" do
      from = "Denver, CO"
      to = "London, UK"

      directions = MapquestService.get_directions(from, to)

      expect(directions.keys).to eq([:route, :info])
      expect(directions[:route]).to have_key(:routeError)
      expect(directions[:route][:routeError][:errorCode]).to be_an(Integer)
      expect(directions[:info]).to have_key(:statuscode)
      expect(directions[:info][:statuscode]).to be_an(Integer)
    end
  end
end