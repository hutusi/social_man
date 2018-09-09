module SocialMan
  module ActionObject

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_action_object
        has_many :passive_actions, class_name: 'Action', as: :action_object,
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
        Action.where(action_type: action_type, action_subject: action_subject, action_object: self)
              .destroy_all
      end

      SocialMan.actions.each do |action|
        define_method action.passive_action do |action_subject|
          taken_action_by action_subject, action.type
        end

        # define_method "#{action.passive_action}!" do |action_subject|
        #   send action.action, action_subject || raise Exception
        # end

        define_method "#{action.passive_action}?" do |action_subject|
          passive_to? action_subject, action.type
        end

        define_method action.passive_undo do |action_subject|
          undo_action_by action_subject, action.type
        end

        # define_method "#{action.passive_undo}!" do |action_subject|
        #   send action.passive_undo, action_subject || raise Exception
        # end

        define_method "#{action.passive_undo}?" do |action_subject|
          !passive_to? action_subject, action.type
        end

        # todo
        # define_method action.all_subjects do |action_subject|
        #   ids = active_actions.pluck(:action_subject_id)
        #   subject_class.where id: ids
        # end
      end

      # subjects_prefix 
      def method_missing(method_name, *args)
        action_type, subject_class = find_subject_class method_name.to_s

        if subject_class.nil?
          super
        else
          ids = passive_actions.where(action_type: action_type).pluck(:action_subject_id)
          subject_class.where id: ids
        end
      end

      private

        def find_subject_class(method_name)
          action_type = ''
          subject_type = nil
          SocialMan.actions.each do |action|
            if method_name.start_with? action.subjects_prefix
              action_type = action.type
              subject_name = method_name.remove action.subjects_prefix
              subject_type = subject_name.singularize.camelize unless subject_name.blank?
              break
            end
          end

          [action_type, subject_type&.constantize]
        end
    end

  end
end
