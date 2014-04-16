class AddCuriosityTable < ActiveRecord::Migration
  def change
    create_table :curiosities do |t|
      t.integer :activity_id
      t.integer :user_id

      t.timestamps
    end

    add_index :curiosities, :activity_id
    add_index :curiosities, :user_id
  end
end
