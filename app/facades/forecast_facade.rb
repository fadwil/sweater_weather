class ForecastFacade
  def self.fetch_forecast(coordinates)
    request = ForecastService.get_forecast(coordinates)
    all_data = {
      current_weather: current(request[:current]),
      daily_weather: daily(request[:forecast][:forecastday]),
      hourly_weather: hourly(request[:forecast][:forecastday][0][:hour])
    }
    Forecast.new(all_data)
  end
  
  def self.current(request)
    {
      last_updated: request[:last_updated],
      temperature: request[:temp_f],
      feels_like: request[:feelslike_f],
      humidity: request[:humidity],
      uvi: request[:uv],
      visibility: request[:vis_miles],
      condition: request[:condition][:text],
      icon: request[:condition][:icon],
    }
  end

  def self.daily(request)
    request.map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def self.hourly(request)
    request.map do |hour|
      {
        time: hour[:time].chars.last(5).join,
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end