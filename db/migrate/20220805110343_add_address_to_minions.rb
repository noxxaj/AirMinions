class AddAddressToMinions < ActiveRecord::Migration[6.1]
  def change
    add_column :minions, :address, :string
  end
end
