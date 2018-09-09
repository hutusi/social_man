module SocialMan
  module ActionObject

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_action_object
        has_many :passive_actions, class_name: 'Action',
              dependent: :destroy

        include SocialMan::ActionObject::InstanceMethods
      end
    end

    module InstanceMethods
      def taken_action_by(action_subject, action_type = 'Action')
        Action.create action_type: action_type, action_subject: action_subject, action_object: self
      end

      def passive_to?(action_subject, action_type = 'Action')
        Action.exists? action_type: action_type, action_subject: action_subject, action_object: self
      end

      def undo_action_by(action_subject, action_type = 'Action')
        Action.destroy action_type: action_type, action_subject: action_subject, action_object: self
      end

    end

  end
end
