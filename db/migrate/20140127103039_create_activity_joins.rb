class CreateActivityJoins < ActiveRecord::Migration
  def change
    create_table :activity_joins do |t|
      t.integer :activity_id
      t.integer :user_id

      t.timestamps
    end

    add_index :activity_joins, :activity_id
    add_index :activity_joins, :user_id
  end
end
