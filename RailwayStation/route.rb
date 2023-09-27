# frozen_string_literal: true
require_relative 'instance_counter'
# Route class
class Route
  include InstanceCounter
  attr_reader :stations, :name

  def initialize(start_station, end_station)
    register_instance
    @stations = [Station.new(start_station), Station.new(end_station)]
    @name = "#{start_station} - #{end_station}"
    validate!
  end

  def valid?
    validate!
  rescue
    false
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
  def validate!
    raise ArgumentError, "Invalid station. Expected a Station object." unless station.is_a?(Station)
    true
  end
end
