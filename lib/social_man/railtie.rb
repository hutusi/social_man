require 'rails'

module ActsAsFollower
  class Railtie < Rails::Railtie

    initializer "social_man.active_record" do |app|
      ActiveSupport.on_load :active_record do
        include SocialMan::ActionSubject
        include SocialMan::ActionObject
      end
    end

  end
end
