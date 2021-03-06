class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :activity_id
      t.integer :user_id
      t.text :text

      t.timestamps
    end
    add_index :comments, :activity_id
    add_index :comments, :user_id
  end
end
