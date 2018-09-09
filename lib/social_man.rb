require "social_man/version"
require "social_man/engine"
require 'social_man/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3

module SocialMan
  autoload :ActionSubject, 'social_man/action_subject'
  autoload :ActionObject, 'social_man/action_object'
  autoload :ActionModel, 'social_man/action_model'
end
