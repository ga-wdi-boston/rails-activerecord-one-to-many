class AddPeopleToPets < ActiveRecord::Migration
  def change
    add_reference :pets, :person, index: true, foreign_key: true
  end
end
