# frozen_string_literal: true

# WagonCargo
class WagonCargo < Wagon
  def initialize(number)
    @type = :cargo
    super
  end
end
