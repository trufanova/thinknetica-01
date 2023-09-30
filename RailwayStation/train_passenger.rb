# frozen_string_literal: true

# PassengerTrain
class TrainPassenger < Train
  attr_reader :type

  def initialize(number, manufacturer)
    super
    @type = :passenger
    Train.increment_instances
  end
end
