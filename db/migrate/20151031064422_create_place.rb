class CreatePlace < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :city
      t.string :state
      t.string :country
      t.integer :population
    end
  end
end
