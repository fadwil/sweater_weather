class ForecastService
  def self.conn
    Faraday.new(url: "https://api.weatherapi.com/") do |f|
      f.params["key"] = Rails.application.credentials.weather[:api_key]
    end
  end

  def self.get_forecast(coordinates)
    response = conn.get("v1/forecast.json") do |f|
      f.params["q"] = coordinates
      f.params["days"] = 5
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end