module SocialMan
  class Engine < ::Rails::Engine
    initializer "social_man.init_action", after: :load_config_initializers do
      # Ensure eager_load Action model to init methods
      require "action"
    end
  end
end
