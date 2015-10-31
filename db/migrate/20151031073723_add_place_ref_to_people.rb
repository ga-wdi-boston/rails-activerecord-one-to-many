class AddPlaceRefToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :place, index: true, foreign_key: true
  end
end
