class AddPhotoToMinions < ActiveRecord::Migration[6.1]
  def change
    add_column :minions, :photo, :string
  end
end
