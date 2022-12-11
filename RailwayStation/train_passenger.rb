# frozen_string_literal: true

# PassengerTrian
class TrainPassenger < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :passenger
  end

  def attach_wagon(wagon)
    if wagon.type != type
      puts "You try to attach a cargo wagon to passenger's train. Please, shure that the wagon has a passenger type"
      return
    end
    super
  end
end
