# frozen_string_literal: true

class Route
  @@stations = []
  attr_reader :name

  def initialize(start_station, end_station)
    @@stations.push(start_station)
    @@stations.push(end_station)
    @name = "#{start_station} - #{end_station}"
  end

  def add_station(station)
    last_station = @@stations.last
    @@stations[-1] = station
    @@stations.push(last_station)
  end

  def del_station(station)
    if (@@stations.first != station) && (@@stations.last != station)
      @@stations.delete(station)
    else
      puts "You can't delete first and last station of route"
    end
  end

  def show_stations
    puts 'Stations list: '
    @@stations.each { |station| puts station }
  end

  def stations
    @@stations
  end
end
