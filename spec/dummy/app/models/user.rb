class User < ApplicationRecord
  validates_presence_of :name

  acts_as_action_subject
end
