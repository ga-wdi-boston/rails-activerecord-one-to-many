class AssociateCitiesWithPeople < ActiveRecord::Migration
  def change
    add_reference :people, :home_town, index: true
    add_foreign_key :people, :cities, column: :home_town_id
  end
end
