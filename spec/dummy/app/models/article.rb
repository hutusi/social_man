class Article < ApplicationRecord
  validates_presence_of :title

  acts_as_action_object
end
