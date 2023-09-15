# frozen_string_literal: true

# PassengerTrain
class TrainPassenger < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :passenger
  end
end
