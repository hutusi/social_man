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

      def likes(object)
        Like.create subject: self, object: object
      end

      # def likes!(object)
      #   likes object || raise Exception
      # end

      def likes?(object)
        Like.exists? subject: self, object: object
      end

      def unlike(object)
        Like.destroy subject: self, object: object
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
            ids = Like.where(subject: self, object_type: object_type).pluck(:object_id)
            object_class.where id: ids
          end
        else
          super
        end
      end
    end

  end
end
