require 'rails/generators'
require 'rails/generators/migration'

class SocialManGenerator < Rails::Generators::Base
  
  include Rails::Generators::Migration
  
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(dir)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end
  
  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/social_man_create_actions.rb',
                       migration_version: migration_version
  end

  def create_model
    template "model.rb", File.join('app/models', "actions.rb")
  end

  def copy_initializer_file
    template "initializer.rb", "config/initializers/social_man.rb"
  end

  private

  def rails5?
    Rails.version.start_with? '5'
  end

  def migration_version
    if rails5?
      "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
    end
  end
  
end
