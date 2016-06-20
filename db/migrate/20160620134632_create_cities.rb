class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :population
      t.string :name
      t.string :country
      t.string :region
      t.decimal :longitude, precision: 5, scope: 3
      t.decimal :latitude, precision: 6, scope: 3

      t.timestamps null: false
    end
  end
end
