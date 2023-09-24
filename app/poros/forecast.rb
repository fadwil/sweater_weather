class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = data[:current_weather]
    @daily_weather = data[:daily_weather]
    @hourly_weather = data[:hourly_weather]
  end
end