# frozen_string_literal: true
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'instance_tracker'

# Train class
class Train
  include Manufacturer
  include InstanceCounter
  include InstanceTracker

  attr_reader :speed, :number, :stations, :type, :current_station, :next_station, :previous_station, :wagons

  NUMBER_FORMAT = /^[a-zA-Z\d]{3}-?[a-zA-Z\d]{2}$/
  MANUFACTURER_FORMAT = /^[a-zA-Z0-9\s]{2,}$/

  def self.find(train_number)
    trains = self.instances

    trains.each do |key, train|
      return "Train number: #{train.number}, Type: #{train.type}, Manufacturer: #{train.manufacturer}, Speed: #{train.speed}" if train.number == train_number
    end
    nil
  end

  def initialize(number, manufacturer)
    register_instance
    @speed = 0
    @wagons = []
    @number = number
    @manufacturer = manufacturer
    validate!
    self.class.add_instance(self)
  end

  def valid?
    validate!
  rescue
    false
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

  def attach_wagon
    validate_wagon!
    wagons << wagon
  end

  def detach_wagon(wagon)
    unless speed.zero?
      puts "You can't dettach wagons while the train is moving"
      return
    end
    wagons.each do |wagon_elem|
      return wagons.delete(wagon_elem) if wagon_elem == wagon

      puts 'Wagon successfully detached'.colorize(:green)
    end
    puts "There is no wagon with №#{number} at this train".colorize(:red)
  end

  def go_next_station
    if @current_station == @stations[-1]
      puts "It's last station in route. There is no next stations".colorize(:red)
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

  def validate!
    raise ArgumentError, "Manufacturer must contain at least 2 letters or digits" if manufacturer !~ MANUFACTURER_FORMAT
    raise ArgumentError, "Number of train must contain only letters or digits: ***-** or *****" if number !~ NUMBER_FORMAT
    true
  end
  
  def validate_wagon!
    raise ArgumentError, "The type of train and carriage should be similar" unless type == wagon.type
    raise ArgumentError, "Please, stop the train before attaching wagons" unless speed.zero?
    raise ArgumentError, "This wagon is already attached. Please enter correct wagon" if wagons.include?(wagon)
  end


end
