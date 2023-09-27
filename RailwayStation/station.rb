# frozen_string_literal: true
require_relative 'instance_counter'
require_relative 'instance_tracker'
# Station class
class Station
  include InstanceCounter
  include InstanceTracker
  attr_reader :trains, :name

  NAME_FORMAT = /^[a-zA-Z0-9\s]+$/

  def initialize(value)
    register_instance
    @name = value.strip.capitalize
    @trains = []
    self.class.add_instance(self)
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def self.all 
    stations = self.instances
    stations.each do  |key, value|
      puts value.name
    end
  end

  def take_train(train)
    trains.push(train) if trains.include?(train) == false
  end

  def send_train(train)
    trains.delete(train)
  end

  def show_trains
    puts 'List trains at the station: '.colorize(:green)
    trains.each { |train| puts train }
  end

  def show_trains_by_types(type)
    sorted_trains = []
    trains.each do |train|
      sorted_trains << train if train.type == type
    end
    puts "#{type.to_s.capitalize} trains: #{sorted_trains.size}"

    sorted_trains.each { |train| puts train.number }
  end

  private 

  def validate!
    raise ArgumentError, "Name must contain only letters or digits" if name !~ NAME_FORMAT
    true
  end
end
