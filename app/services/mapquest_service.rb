class MapquestService
  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com/") do |f|
      f.params["key"] = Rails.application.credentials.mapquest[:api_key]
    end
  end

  def self.get_lat_lng(location)
    response = conn.get("geocoding/v1/address") do |f|
      f.params["location"] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_directions(from, to)
    response = conn.get("directions/v2/route") do |f|
      f.params["from"] = from
      f.params["to"] = to
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end