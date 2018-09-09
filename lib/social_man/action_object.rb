module SocialMan
  module ActionObject

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_action_object
        has_many :passive_actions, class_name: 'Action',
              foreign_id: 'object_id',
              dependent: :destroy
      end
    end
  end
end
