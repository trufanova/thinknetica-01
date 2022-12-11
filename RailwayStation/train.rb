# frozen_string_literal: true

# Train class
class Train
  attr_accessor :speed, :number
  attr_reader :stations, :type, :current_station, :next_station, :previous_station, :wagons

  def initialize(number)
    @speed = 0
    @wagons = []
    @number = number
  end

  def stop
    self.speed = 0
  end

  def attach_wagon(wagon)
    unless speed.zero?
      puts "You can't attach wagons while the train is moving"
      return
    end
    if @wagons.include?(wagon)
      puts 'This wagon is already attacht. Please enter correct wagon'
      return
    end
    @wagons << wagon
  end

  def detach_wagon(number)
    unless speed.zero?
      puts "You can't dettach wagons while the train is moving"
      return
    end
    @wagons.each do |wagon|
      return @wagons.delete(wagon) if wagon.number == number.to_i
    end
    puts "There is no wagon with №#{number} at this train"
  end

  def route(route)
    @route = route.name
    @stations = route.stations
    @previous_station = nil
    @next_station = @stations[1]
    @current_station = @stations[0]
  end

  def go_next_station
    if current_station == @stations[-1]
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
