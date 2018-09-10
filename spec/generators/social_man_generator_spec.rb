# # Generators are not automatically loaded by Rails
# require 'generators/social_man_generator'

# describe SocialManGenerator do
#   # Tell the generator where to put its output (what it thinks of as Rails.root)
#   destination File.expand_path("../../../../tmp", __FILE__)
#   teardown :cleanup_destination_root

#   let(:adapter) { 'SQLite3Adapter' }
#   before {
#     prepare_destination
#   }

#   def cleanup_destination_root
#     FileUtils.rm_rf destination_root
#   end

#   describe 'specifying only Role class name' do
#     before {
#       run_generator
#     }

#     describe 'config/initializers/social_man.rb' do
#       subject { file('config/initializers/social_man.rb') }
#       it { should exist }
#       it { should contain "SocialMan.configure do |config|"}
#       it { should contain "# config.actions = [:like, :star, :follow]" }
#     end

#     describe 'app/models/action.rb' do
#       subject { file('app/models/action.rb') }
#       it { should exist }
#       it do
#         if Rails::VERSION::MAJOR < 5
#           should contain "class Role < ActiveRecord::Base"
#         else
#           should contain "class Role < ApplicationRecord"
#         end
#       end
#       it { should contain "include SocialMan::ActionModel" }
#     end

#     describe 'migration file' do
#       subject { migration_file('db/migrate/social_man_create_actions.rb') }

#       it { should be_a_migration }
#       it { should contain "create_table(:actions) do" }
#     end
#   end
# end
