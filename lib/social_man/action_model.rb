# frozen_string_literal: true
module SocialMan
  module ActionModel
    extend ActiveSupport::Concern

    included do
      belongs_to :action_subject, foreign_key: 'subject_id', polymorphic: true
      belongs_to :action_object, foreign_key: 'object_id', polymorphic: true
    end
  end
end
