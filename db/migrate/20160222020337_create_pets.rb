class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.date :born_on
      t.string :kind
      t.string :name

      t.timestamps null: false
    end
  end
end
