class SocialManCreateActions < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :actions do |t|
      t.references :action_subject, polymorphic: true
      t.string :action_type
      t.string :action_options
      t.references :action_object, polymorphic: true

      t.timestamps
    end
  end
end
