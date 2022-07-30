class UpdateStatusDefaultToPendingBookings < ActiveRecord::Migration[6.1]
  def change
    change_column_default :bookings, :status, from: nil, to: 'pending'
  end
end
