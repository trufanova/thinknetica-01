# frozen_string_literal: true

class Train
  attr_accessor :speed
  attr_reader :number_wagons, :stations, :type, :current_station, :next_station, :previous_station

  def initialize(number, type, number_wagons)
    @speed = 0
    @number = number
    @type = type.to_sym
    @number_wagons = number_wagons
  end

  def stop
    self.speed = 0
  end

  def attach_wagon
    if speed.zero?
      @number_wagons += 1
    else
      puts "You can't attach wagons while the train is moving"
    end
  end

  def detach_wagon
    if speed.zero?
      @number_wagons -= 1
    else
      puts "You can't detach wagons while the train is moving"
    end
  end

  def route(route)
    @route = route.name
    @stations = route.stations
    @previous_station = nil
    @next_station = @stations[1]
    @current_station = @stations[0]
  end

  def go_next_station
    if @current_station == @stations[-1]
      puts "It's last station in route. There is no next stations"
      @next_station = nil
      @current_station = @stations[-1]
    else
      @next_station = @stations[@stations.index(@current_station) + 1]
      @previous_station = @stations[@stations.index(@current_station) - 1]
      @current_station = @stations[@stations.index(@current_station) + 1]
    end
  end

  def go_previous_station
    if @current_station == @stations[0]
      puts "It's first station in route. There is no previous stations"
      @previous_station = nil
      @current_station = @stations[0]
    else
      @next_station = @stations[@stations.index(@current_station) + 1]
      @previous_station = @stations[@stations.index(@current_station) - 1]
      @current_station = @stations[@stations.index(@current_station) - 1]
    end
  end
end
