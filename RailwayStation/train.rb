# frozen_string_literal: true
require_relative 'manufacturer'
require_relative 'instance_counter'

# Train class
class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :speed, :number, :stations, :type, :current_station, :next_station, :previous_station, :wagons

  def self.find(train_number)
    trains = ObjectSpace.each_object(self).to_a
    trains.each do |train|
      return train if train.number == train_number
    end
    nil
  end

  def initialize(number, manufacturer)
    register_instance
    @speed = 0
    @wagons = []
    @number = number
    @manufacturer = manufacturer
  end

  def route(route)
    @route = route.name
    @stations = route.stations
    @previous_station = nil
    @next_station = @stations[1]
    @current_station = @stations[0]
  end

  def stop
    self.speed = 0
  end

  def attach_wagon(wagon)
    if wagons.include?(wagon)
      puts 'This wagon is already attached. Please enter correct wagon'.colorize(:red)
      return
    end

    if speed.zero? && wagon.type == type
      wagons << wagon
      puts 'Wagon successfully attached'.colorize(:green)
    end
    puts 'The type of train and carriage should be similar' unless type == wagon.type
    puts 'Please, stop the train before attaching wagons' unless speed.zero?
  end

  def detach_wagon(wagon)
    unless speed.zero?
      puts "You can't dettach wagons while the train is moving"
      return
    end
    wagons.each do |wagon_elem|
      return wagons.delete(wagon_elem) if wagon_elem == wagon

      puts 'Wagon successfully detached'.green
    end
    puts "There is no wagon with №#{number} at this train".colorize(:red)
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
      puts "It's first station in route. There is no previous stations".colorize(:green)
      @previous_station = nil
      @current_station = @stations[0]
    else
      @next_station = @stations[@stations.index(@current_station) + 1]
      @previous_station = @stations[@stations.index(@current_station) - 1]
      @current_station = @stations[@stations.index(@current_station) - 1]
    end
  end

  private

  attr_writer :speed, :number
end
