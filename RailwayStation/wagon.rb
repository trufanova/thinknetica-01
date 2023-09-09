# frozen_string_literal: true
require_relative 'manufacturer'
# wagon
class Wagon
  include Manufacturer
  attr_reader :type, :number

  def initialize(number, type)
    @number = number
    @type = type
  end
end
