class AddActivityCategoryIdToActivities < ActiveRecord::Migration
  def change
    create_table :activities_activity_categories do |t|
      t.integer :activity_category_id
      t.integer :activity_id
    end
  end
end
