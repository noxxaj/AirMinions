class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true
      t.references :minion, null: false, foreign_key: true
      t.boolean :confirmed

      t.timestamps
    end
  end
end
