# frozen_string_literal: true

class Station
  @@trains = []
  @@cargo = []
  @@passangers = []
  def initialize(name)
    @name = name
  end

  def take_train(train)
    @@trains.push(train)
    if train.type == :cargo
      @@cargo.push(train)
    else
      @@passangers.push(train)
    end
  end

  def send_train(train)
    @@trains.delete(train)
    if train.type == :cargo
      @@cargo.delete(train)
    else
      @@passangers.delete(train)
    end
  end

  def show_trains
    puts 'List trains at the station: '
    @@trains.each do |train|
      puts train
    end
  end

  def show_trains_by_types
    puts "Cargo trains: #{@@cargo.size}"
    @@cargo.each { |train| puts train }
    puts "Passangers trains:  #{@@passangers.size}"
    @@passangers.each { |train| puts train }
  end
end
