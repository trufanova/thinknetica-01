module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.instance_variable_set('@instances_by_class', Hash.new(0))
  end

  module ClassMethods
    def instances
      instances_by_class.values.sum
    end

    def instances_by_class
      @instances_by_class ||= Hash.new(0)
    end

    def increment_instances
      instances_by_class[self] += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.increment_instances
    end
  end
end