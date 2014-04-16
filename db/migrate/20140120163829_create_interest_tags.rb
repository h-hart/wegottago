class CreateInterestTags < ActiveRecord::Migration
  def change
    create_table :interest_tags do |t|
      t.integer :id_activity
      t.string :tag

      t.timestamps
    end
  end
end
