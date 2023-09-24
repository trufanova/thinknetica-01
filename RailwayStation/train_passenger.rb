# frozen_string_literal: true

# PassengerTrain
class TrainPassenger < Train
  attr_reader :type

  def initialize(number, manufacturer)
    super
    @type = :passenger
    Train.increment_instances
    # puts "Train instances: #{Train.instances_count} "
    # puts "Passenger instances: #{TrainPassenger.instances_by_class}"
  end
end
