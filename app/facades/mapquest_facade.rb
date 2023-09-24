class MapquestFacade
  def self.fetch_lat_lng(location)
    request = MapquestService.get_lat_lng(location)
    lat_lng_hash = request[:results][0][:locations][0][:latLng]
    "#{lat_lng_hash[:lat]},#{lat_lng_hash[:lng]}"
  end
end