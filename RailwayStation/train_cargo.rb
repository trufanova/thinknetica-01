# frozen_string_literal: true

# CargoTrain class
class TrainCargo < Train
  attr_reader :type

  def initialize(number, manufacturer)
    super
    @type = :cargo
    Train.increment_instances
    # puts "Train instances: #{Train.instances_count} "
    # puts "Cargo instances: #{TrainCargo.instances_by_class}"
  end
end
