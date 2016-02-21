class AddHairAndEyeColorToPerson < ActiveRecord::Migration
  def change
    add_column :people, :hair_color, :string
    add_column :people, :eye_color, :string
  end
end
