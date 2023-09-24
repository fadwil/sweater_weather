require "rails_helper"

RSpec.describe Forecast do
  let(:gainesville_forecast_info) {
    {
      current_weather:
        {
          last_updated: "2023-09-23 18:15",
          temperature: 84.9,
          feels_like: 86.1,
          humidity: 40,
          uvi: 8.0,
          visibility: 9.0,
          condition: "Partly cloudy",
          icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
        },
      daily_weather: 
      [
        {
          date: "2023-09-23",
          sunrise: "07:18 AM",
          sunset: "07:25 PM",
          max_temp: 90.1,
          min_temp: 61.3,
          condition: "Sunny",
          icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          date: "2023-09-24",
          sunrise: "07:19 AM",
          sunset: "07:24 PM",
          max_temp: 92.7,
          min_temp: 61.3,
          condition: "Sunny",
          icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
        }
      ],
      hourly_weather: 
      [
        {
          time: "00:00",
          temperature: 76.3,
          conditions: "Clear",
          icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          time: "01:00",
          temperature: 74.8,
          conditions: "Clear",
          icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
        }
      ]
    }
  }
  
  describe "instance methods" do
    it "exists and has attributes" do
      gnv_forecast = Forecast.new(gainesville_forecast_info)

      expect(gnv_forecast.current_weather).to eq({
        last_updated: "2023-09-23 18:15",
        temperature: 84.9,
        feels_like: 86.1,
        humidity: 40,
        uvi: 8.0,
        visibility: 9.0,
        condition: "Partly cloudy",
        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
      })

      expect(gnv_forecast.daily_weather[0]).to eq({
        date: "2023-09-23",
        sunrise: "07:18 AM",
        sunset: "07:25 PM",
        max_temp: 90.1,
        min_temp: 61.3,
        condition: "Sunny",
        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
      })

      expect(gnv_forecast.daily_weather[1]).to eq({
        date: "2023-09-24",
        sunrise: "07:19 AM",
        sunset: "07:24 PM",
        max_temp: 92.7,
        min_temp: 61.3,
        condition: "Sunny",
        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
      })

      expect(gnv_forecast.hourly_weather[0]).to eq({
        time: "00:00",
        temperature: 76.3,
        conditions: "Clear",
        icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
      })

      expect(gnv_forecast.hourly_weather[1]).to eq({
        time: "01:00",
        temperature: 74.8,
        conditions: "Clear",
        icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
      })
    end
  end
end
  