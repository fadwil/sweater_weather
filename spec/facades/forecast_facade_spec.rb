require "rails_helper"

RSpec.describe ForecastFacade do
  describe "happy path tests", :vcr do
    it "returns all forecast info for location" do
      forecast = ForecastFacade.fetch_forecast("29.65198,-82.32265") #gnv
      expect(forecast).to be_a(Forecast)
      expect(forecast.id).to eq(nil)
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.current_weather.keys).to eq([:last_updated,
                                                    :temperature,
                                                    :feels_like,
                                                    :humidity,
                                                    :uvi,
                                                    :visibility,
                                                    :condition,
                                                    :icon
                                                    ])
      expect(forecast.daily_weather).to be_a(Array)
      expect(forecast.daily_weather.size).to eq(5)
      expect(forecast.daily_weather.first.keys).to eq([:date,
                                                  :sunrise,
                                                  :sunset,
                                                  :max_temp,
                                                  :min_temp,
                                                  :condition,
                                                  :icon])
      expect(forecast.hourly_weather).to be_a(Array)
      expect(forecast.hourly_weather.first.keys).to eq([:time,
                                                  :temperature,
                                                  :conditions,
                                                  :icon])
    end
  end
end