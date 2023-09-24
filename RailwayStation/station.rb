# frozen_string_literal: true
require_relative 'instance_counter'
# Station class
class Station
  include InstanceCounter
  attr_reader :trains, :name

  def initialize(value)
    register_instance
    @name = value.strip.capitalize
    @trains = []
  end

  #В классе Station (жд станция) создать метод класса all, который возвращает все станции (объекты), созданные на данный момент
  def self.all 
    ObjectSpace.each_object(self) do |station|
      puts station.name
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
end
