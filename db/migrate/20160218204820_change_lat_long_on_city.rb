class ChangeLatLongOnCity < ActiveRecord::Migration
  def up
    change_column :cities, :latitude, :decimal, precision: 5, scale: 3
    change_column :cities, :longitude, :decimal, precision: 6, scale: 3
  end

  def down
    change_column :cities, :latitude, :float
    change_column :cities, :longitude, :float
  end
end
