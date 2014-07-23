class CreateTableActivities < ActiveRecord::Migration
  def change
    create_table :delivery_uncle_activities do |t|
      t.string :actor
      t.text :actor_desc

      t.string :verb
      t.text :verb_desc

      t.string :object_type
      t.text :object_details

      t.boolean :expired

      t.timestamps
    end
  end
end
