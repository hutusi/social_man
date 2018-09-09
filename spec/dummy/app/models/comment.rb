class Comment < ApplicationRecord
  validates_presence_of :body

  acts_as_action_object
end
