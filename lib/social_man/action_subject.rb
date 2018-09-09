module SocialMan
  module ActionSubject

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_action_subject
        has_many :active_actions, class_name: 'Action', as: :action_subject,
              dependent: :destroy

        include SocialMan::ActionSubject::InstanceMethods
      end
    end

    module InstanceMethods
      def take_action_on(action_object)
        Action.create action_type: 'Action', action_subject: self, action_object: action_object
      end

      def active_to?(action_object)
        Action.exists? action_type: 'Action', action_subject: self, action_object: action_object
      end

      def likes(action_object)
        Action.create action_type: 'Like', action_subject: self, action_object: action_object
      end

      # def likes!(object)
      #   likes object || raise Exception
      # end

      def likes?(action_object)
        Action.exists? action_type: 'Like', action_subject: self, action_object: action_object
      end

      def unlike(action_object)
        Action.destroy action_type: 'Like', action_subject: self, action_object: action_object
      end

      # def unlike!(object)
      #   unlikes object || raise Exception
      # end

      def method_missing(method_name, *args)
        method_name_string = method_name.to_s
        if method_name_string.start_with?('liked_')
          object_name = method_name_string.remove 'liked_'
          object_type = object_name.singularize.camelize
          object_class = object_type.constantize

          if object_class.nil?
            super
          else
            ids = active_actions.where(action_type: 'Like').pluck(:action_object_id)
            object_class.where id: ids
          end
        else
          super
        end
      end
    end

  end
end
