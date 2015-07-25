module SessionUser

  def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend(ClassMethods)
  end

  module ClassMethods
    def current_user
      User.current
    end
    def current_user_id
      current_user.try(:id)
    end
  end


  module InstanceMethods

    def current_user
      User.current
    end

    def current_user_id
      current_user.try(:id)
    end

  end

end