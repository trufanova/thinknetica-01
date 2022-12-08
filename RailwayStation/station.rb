# frozen_string_literal: true

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name.to_sym
    @trains = []
  end

  def take_train(train)
    trains.push(train) if trains.include?(train) == false
  end

  def send_train(train)
    trains.delete(train)
  end

  def show_trains
    puts 'List trains at the station: '
    trains.each { |train| puts train }
  end

  def show_trains_by_types(type)
    sorted_trains = []
    trains.each do |train|
      sorted_trains << train if train.type == type
    end
    puts "#{type.to_s.capitalize} trains: #{sorted_trains.size}"

    sorted_trains.each{|train| puts train.number}
  end
end
