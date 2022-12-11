# frozen_string_literal: true

# CargoTrain class
class TrainCargo < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :cargo
  end

  def attach_wagon(wagon)
    if wagon.type != type
      puts 'You try to attach a passenger wagon to cargo train. Please, shure that the wagon has a cargo type'
      return
    end
    super
  end
end
