# frozen_string_literal: true

# wagon
class Wagon
  attr_reader :type, :number

  def initialize(number)
    @number = number.to_i
  end
end
