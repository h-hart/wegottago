class CreateReservations < ActiveRecord::Migration
  def up
    create_table :reservations do |t|
      t.string :email
      t.string :invitation_sent

      t.timestamps
    end
  end

  def down
  end
end
