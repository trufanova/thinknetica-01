# frozen_string_literal: true

# CargoTrain class
class TrainCargo < Train
  attr_reader :type

  def initialize(number, manufacturer)
    super
    @type = :cargo
    Train.increment_instances
  end
end
