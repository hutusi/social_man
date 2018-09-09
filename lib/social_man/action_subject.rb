module SocialMan
  module ActionSubject

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_action_subject
        has_many :active_actions, class_name: 'Action',
              dependent: :destroy
        # has_many :action_objects, class_name: 'Action',
        #         source: :subject,
        #         through: :active_actions

        include SocialMan::ActionSubject::InstanceMethods
      end
    end

    module InstanceMethods
      def take_action_on(object)
        Action.create subject: self, object: object
      end

      def active_to?(object)
        Action.exists? subject: self, object: object
      end
    end

  end
end
