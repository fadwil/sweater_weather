require "rails_helper"

RSpec.describe MapquestFacade do
  describe "happy path tests", :vcr do
    it "returns lat lng of a location" do
      location = "Gainesville,FL"
      lat_lng = MapquestFacade.fetch_lat_lng(location)
      expect(lat_lng).to eq("29.65198,-82.32265")
    end
  end
end