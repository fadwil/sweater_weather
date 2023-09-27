class RoadTripFacade
  def self.create_road_trip(origin, destination)
    directions = MapquestService.get_directions(origin, destination)

    if directions[:info][:statuscode] == 402
      RoadTrip.new({start_city: origin, end_city: destination, travel_time: "impossible", weather_at_eta: {}})
    else
      travel_time = directions[:route][:formattedTime]
      coordinates = get_coordinates(destination)
      weather_at_eta = fetch_weather_at_eta(coordinates, travel_time)

      road_trip_data = {
        start_city: origin,
        end_city: destination, 
        travel_time: travel_time,
        weather_at_eta: weather_at_eta
      }
      
      RoadTrip.new(road_trip_data)
    end
  end

  def self.get_coordinates(destination)
    lat_lng = MapquestService.get_lat_lng(destination)[:results][0][:locations][0][:latLng]
    "#{lat_lng[:lat]},#{lat_lng[:lng]}"
  end

  def self.fetch_weather_at_eta(coordinates, travel_time)
    arrival_time = Time.now + travel_time.to_i.seconds
    forecast_data = ForecastService.get_forecast(coordinates)
  
    if travel_time == "impossible"
      weather_at_eta = {}
    else
      weather_at_eta = {
        datetime: arrival_time.strftime("%Y-%m-%d %H:%M:%S"),
        temperature: forecast_data[:current][:temp_f],
        condition: forecast_data[:current][:condition][:text]
      }
    end
    weather_at_eta
  end
end
