module InstanceTracker
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def instances
      @instances ||= {}
    end

    def add_instance(instance)
      instances[instance.object_id] = instance
    end

  end
end