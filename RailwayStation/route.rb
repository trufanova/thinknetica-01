# frozen_string_literal: true

# Route class
class Route
  attr_reader :stations, :name

  def initialize(start_station, end_station)
    # start_station_normalize = start_station.to_s.strip.capitalize
    # end_station_normalize = end_station.to_s.strip.capitalize
    @stations = [Station.new(start_station), Station.new(end_station)]
    @name = "#{start_station} - #{end_station}"
  end

  def add_station(station)
    last_station = @stations.last
    stations[-1] = station
    stations.push(last_station)
  end

  def del_station(station)
    return unless (stations.first != station) && (stations.last != station)

    stations.delete(station)
  end

  def show_stations
    puts 'Stations list: '
    stations.each { |station| puts station.name }
  end

  private

  attr_writer :stations, :name
end
