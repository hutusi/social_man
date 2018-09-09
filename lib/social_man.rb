require "social_man/version"
require "social_man/engine"
require 'social_man/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3
require 'social_man/configure'
require 'social_man/action_thesaurus'

module SocialMan
  extend Configure

  autoload :ActionSubject, 'social_man/action_subject'
  autoload :ActionObject, 'social_man/action_object'
  autoload :ActionModel, 'social_man/action_model'
end
