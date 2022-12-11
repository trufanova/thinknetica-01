# frozen_string_literal: true

# Wagon Passenger
class WagonPassenger < Wagon
  def initialize(number)
    @type = :passenger
    super
  end
end
