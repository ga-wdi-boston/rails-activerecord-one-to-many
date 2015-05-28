class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :rating
      t.text :desc
      t.integer :length

      t.timestamps null: false
    end
  end
end
