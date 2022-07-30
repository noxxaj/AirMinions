class CreateMinions < ActiveRecord::Migration[6.1]
  def change
    create_table :minions do |t|
      t.string :name
      t.text :description
      t.string :skills
      t.integer :price_per_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
