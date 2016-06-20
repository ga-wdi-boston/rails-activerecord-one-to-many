class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :length
      t.integer :rating

      t.timestamps null: false
    end
  end
end
