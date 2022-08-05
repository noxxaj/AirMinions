class AddCoordinatesToMinions < ActiveRecord::Migration[6.1]
  def change
    add_column :minions, :latitude, :float
    add_column :minions, :longitude, :float
  end
end
