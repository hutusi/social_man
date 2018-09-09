class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.references :action_subject, polymorphic: true
      t.string :action_type
      t.string :action_options
      t.references :action_object, polymorphic: true
  
      t.timestamps
    end
    
    create_table :users, force: true do |t|
      t.column :name, :string
    end
  
    create_table :articles, force: true do |t|
      t.column :title, :string
    end
  end
end
