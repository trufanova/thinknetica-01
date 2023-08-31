# frozen_string_literal: true

# CargoTrain class
class TrainCargo < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :cargo
  end
end
