# frozen_string_literal: true
require_relative 'manufacturer'
require_relative 'validation'
# wagon
class Wagon
  include Manufacturer
  include Validation
  attr_reader :type, :number

  NUMBER_FORMAT = /^[a-zA-Z0-9\s]+$/

  def self.find(wagon_number)
    wagons = self.instances
    wagons.each do |key, wagon|
      return "Wagon number: #{wagon.number}, Type: #{wagon.type}, Manufacturer: #{wagon.manufacturer}" if wagon.number == wagon_number
    end
    nil
  end

  def initialize(number, type)
    @number = number
    @type = type
    validate!
  end
  
  private

  def validate!
    valid_types = [:cargo, :passenger]
    raise ArgumentError, "Number can't be empty" if number.nil? || number.empty?
    raise ArgumentError, "Number must contain only letters, digits, or spaces" unless number =~ NUMBER_FORMAT
    raise ArgumentError, "Invalid type. Allowed types: #{valid_types.join(', ')}" unless valid_types.include?(type)
  end
end
