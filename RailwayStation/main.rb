# frozen_string_literal: true
require 'colorize'

# Main class
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'


MENU = [
  { index: 1, title: 'Create new station', action: :create_station },
  { index: 2, title: 'Create new train', action: :create_train },
  { index: 3, title: 'Create new route and manage stations', action: :create_route },
  { index: 4, title: 'Set route to train', action: :set_route_to_train },
  { index: 5, title: 'Create new wagon', action: :create_wagon },
  { index: 6, title: 'Attach wagons to train', action: :attach_wagons_to_train },
  { index: 7, title: 'Detach wagons from train', action: :detach_wagons_from_train },
  { index: 8, title: 'Show attached wagons', action: :show_train_wagons },
  { index: 9, title: 'Move train along route', action: :move_train_along_route },
  { index: 10, title: 'View stations and trains on station', action: :view_stations_and_trains },
  { index: 0, title: 'Exit', action: :exit_from_program }
].freeze

def exit_from_program
  puts 'Bye bye'
  exit
end

def create_station
  puts 'Enter name of new station'
  name_station = gets.chomp.to_sym
  name_class_station = Station.new(name_station)
  puts "Created new station: #{name_class_station.name}"
end

def create_train
  puts 'Enter number of new train'
  number_train = gets.chomp.to_sym
  puts 'Enter type of train: 1 - cargo, 2 - passenger'
  type_train = gets.to_i
  puts 'Enter manufacturer of train:'
  manufacturer = gets.chomp
  case type_train
  when 1
    name_class_train = TrainCargo.new(number_train, manufacturer)
  when 2
    name_class_train = TrainPassenger.new(number_train, manufacturer)
  end
  puts "Created new train: #{name_class_train.number}"
end

def create_wagon
  puts 'Enter number of new wagon'
  number_wagon = gets.chomp.to_sym
  puts 'Enter type of wagon: 1 - cargo, 2 - passenger'
  type_wagon = gets.to_i
  case type_wagon
  when 1
    type_wagon = :cargo
  when 2
    type_wagon = :passenger
  else
    puts 'Error entering type wagon'
  end
  name_class_wagon = Wagon.new(number_wagon, type_wagon)
  puts "Created new wagon: #{name_class_wagon.number}"
end

def show_all_routes
  puts 'List of routes: '
  routes = ObjectSpace.each_object(Route).to_a
  routes.each do |route|
    puts route.name
  end
end

def show_all_trains
  puts 'List of trains: '
  trains = ObjectSpace.each_object(Train).to_a
  trains.each do |train|
    puts train.number
  end
end

def show_all_wagons
  wagons = ObjectSpace.each_object(Wagon).to_a
  wagons.each do |wagon|
    puts wagon.number
  end
end

def find_station(station_name)
  stations = ObjectSpace.each_object(Station).to_a
  puts "Entered name: #{station_name}"
  stations.each do |station|
    puts "Finded name: #{station.name}"
    return station if station.name == station_name
  end
  puts "Station #{station_name} is not exist"
  nil
end

def find_route(route_name)
  routes = ObjectSpace.each_object(Route).to_a
  routes.each do |route|
    return route if route.name == route_name
  end
  puts "Route '#{route_name} is not exist"
  nil
end



def find_wagon(wagon_number)
  wagons = ObjectSpace.each_object(Wagon).to_a
  wagons.each do |wagon|
    return wagon if wagon.number == wagon_number
  end
  nil
end

def create_route
  puts "Enter 'new' for create new route"
  puts "Enter 'manage' for manage stations at route"
  user_answer = gets.chomp.to_sym

  case user_answer
  when :new
    puts 'Creating new route...'
    puts 'Enter start station name: '
    start_station = gets.chomp.strip.capitalize
    puts 'Enter end station name: '
    end_station = gets.chomp.strip.capitalize
    new_route = Route.new(start_station, end_station)
    puts "Create route '#{new_route.name}'"
  when :manage
    puts "Enter 'add' for added station to route"
    puts "Enter 'del' for delete stations from route"
    puts "Enter 'show' for see list stations of route"
    user_answer = gets.chomp.to_sym
    case user_answer
    when :add
      puts 'Adding new station...'

      show_all_routes
      puts 'Enter target route name '
      target_route = gets.chomp.strip
      found_route = find_route(target_route)

      puts 'Enter station name '
      station = Station.new(gets.chomp.strip.capitalize)
      found_route&.add_station(station)

    when :del
      puts 'Deleting station...'
      show_all_routes
      puts 'Enter target route name '
      target_route = gets.chomp
      found_route = find_route(target_route)
      if found_route.nil?
        puts "Route '#{target_route}' is not exist"
      else
        puts 'Enter station name you want to delete '
        station = gets.chomp.to_sym
        found_route.del_station(station)
      end
    when :show
      puts 'Showing stations...'
      show_all_routes
      puts 'Enter target route name '
      target_route = gets.chomp
      found_route = find_route(target_route)
      if found_route.nil?
        puts "Route '#{target_route}' is not exist"
      else
        found_route.show_stations
      end
    else
      puts 'Error!'
    end
  else
    puts 'Error!'
  end
end

def set_route_to_train
  puts 'Enter train you want to set route'
  show_all_trains
  entered_train = gets.chomp.to_sym
  target_train = find_train(entered_train)
  show_all_routes
  puts 'Enter target route name '
  target_route = gets.chomp
  found_route = find_route(target_route)
  target_train.route(found_route) unless found_route.nil?

end

def attach_wagons_to_train
  puts 'Enter train number'
  show_all_trains
  entered_train = gets.chomp.to_sym
  target_train = find_train(entered_train)

  puts 'Enter wagon number '
  puts 'List of wagons: '
  show_all_wagons
  target_wagon = gets.chomp.to_sym
  found_wagon = find_wagon(target_wagon)
  if found_wagon.nil?
    puts "Wagon '#{target_wagon}' is not exist"
    nil
  else
    target_wagon = found_wagon
    type_train = target_train.type
    target_train.attach_wagon(target_wagon)
  end
end

def detach_wagons_from_train
  puts 'Enter train number'
  show_all_trains
  entered_train = gets.chomp.to_sym
  target_train = find_train(entered_train)

  puts 'Enter wagon number '
  puts 'List of wagons: '
  target_train.wagons.each { |wagon| puts wagon.number }
  target_wagon = gets.chomp.to_sym
  found_wagon = find_wagon(target_wagon)
  if found_wagon.nil?
    puts "Wagon '#{target_wagon}' is not exist"
    nil
  else
    target_wagon = found_wagon
    type_train = target_train.type
    target_train.detach_wagon(target_wagon)
    puts 'Please, stop the train before detaching wagons' unless target_train.speed.zero?
  end
end

def show_train_wagons
  puts 'Enter train number'
  show_all_trains
  entered_train = gets.chomp.to_sym
  target_train = find_train(entered_train)
  puts "Train #{target_train.number} contains: "
  target_train.wagons.each { |wagon| puts wagon.number }
end

def move_train_along_route
  puts "Enter 'forward' to move forward"
  puts "Enter 'back' to move back"
  user_answer = gets.chomp.to_sym

  case user_answer
  when :forward
    puts 'Enter train number'
    show_all_trains
    entered_train = gets.chomp.to_sym
    target_train = find_train(entered_train)
    puts target_train
    target_train.go_next_station
    puts "Now train in #{target_train.current_station}"
  when :back
    puts 'Enter train number'
    show_all_trains
    entered_train = gets.chomp.to_sym
    target_train = find_train(entered_train)
    target_train.go_previous_station
    puts "Now train in #{target_train.current_station}".colorize(:green)
  else
    puts 'Error moving train along route'
  end
end

def view_stations_and_trains
  puts 'View stations and trains'
  puts "Enter 'stations' to view list of stations"
  puts "Enter 'trains' to view list of trains on station"
  user_answer = gets.chomp.strip.capitalize

  case user_answer
  when :stations
      show_all_routes
      puts 'Enter target route name '
      target_route = gets.chomp
      found_route = find_route(target_route)
      puts 'List of stations: '.colorize(:green)
      found_route.stations.each{|station| puts station.name}
  when :trains
    # show_all_routes
    puts 'Enter station name '
    target_station = gets.chomp.strip.capitalize
    found_station = find_station(target_station)
    found_station.show_trains
  else 
    puts 'Error!'
  end
end

loop do
  MENU.each do |item|
    puts "Enter #{item[:index]} to #{item[:title]}"
  end
  answer = gets.to_i
  selected_item = MENU.find { |item| item[:index] == answer }
  send(selected_item[:action])
end
