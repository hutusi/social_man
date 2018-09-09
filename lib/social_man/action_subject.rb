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
      def take_action_on(action_object, action_type = 'Action')
        Action.create action_type: action_type, action_subject: self, action_object: action_object
      end

      def active_to?(action_object, action_type = 'Action')
        Action.exists? action_type: action_type, action_subject: self, action_object: action_object
      end

      def undo_action_on(action_object, action_type = 'Action')
        Action.destroy action_type: action_type, action_subject: self, action_object: action_object
      end

      SocialMan.actions.each do |action|
        define_method action.action do |action_object|
          take_action_on action_object, action.type
        end

        # define_method "#{action.action}!" do |action_object|
        #   send action.action, action_object || raise Exception
        # end

        define_method "#{action.action}?" do |action_object|
          active_to? action_object, action.type
        end

        define_method action.undo do |action_object|
          undo_action_on action_object, action.type
        end

        # define_method "#{action.undo}!" do |action_object|
        #   send action.undo, action_object || raise Exception
        # end

        # todo
        # define_method action.all_subjects do |action_object|
        #   ids = active_actions.pluck(:action_object_id)
        #   object_class.where id: ids
        # end
      end

      # objects_prefix 
      def method_missing(method_name, *args)
        action_type, object_class = find_object_class method_name.to_s

        if object_class.nil?
          super
        else
          ids = active_actions.where(action_type: action_type).pluck(:action_object_id)
          object_class.where id: ids
        end
      end

      private

        def find_object_class(method_name)
          action_type = ''
          object_type = nil
          SocialMan.actions.each do |action|
            if method_name.start_with? action.objects_prefix
              action_type = action.type
              object_name = method_name.remove action.objects_prefix
              object_type = object_name.singularize.camelize unless object_name.blank?
              break
            end
          end

          [action_type, object_type&.constantize]
        end
    end

  end
end
