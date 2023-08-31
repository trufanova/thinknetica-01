# frozen_string_literal: true

# PassengerTrian
class TrainPassenger < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :passenger
  end
end
