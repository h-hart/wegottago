class DropIntTagsTable < ActiveRecord::Migration
  def change
    drop_table :interest_tags
  end
end
