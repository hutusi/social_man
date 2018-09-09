# frozen_string_literal: true

# 
# Like, Star

module SocialMan
  module ActionModel
    extend ActiveSupport::Concern

    included do
      belongs_to :subject, polymorphic: true
      belongs_to :object, polymorphic: true
    end
  end
end
