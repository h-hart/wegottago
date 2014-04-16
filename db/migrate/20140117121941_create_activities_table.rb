class CreateActivitiesTable < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :theme_id
      t.string :title
      t.string :personal_quote
      t.datetime :end_datetime
      t.string :location
      t.text :details
      t.integer :people_number
      t.boolean :people_ask_others
      t.boolean :gender_male
      t.boolean :gender_female
      t.boolean :status_single
      t.boolean :status_married
      t.boolean :status_in_relationship
      t.boolean :orientation_straight
      t.boolean :orientation_gay
      t.boolean :orientation_bisexual
      t.boolean :age_all
      t.integer :age_from
      t.integer :age_to

      t.timestamps
    end
  end
end
