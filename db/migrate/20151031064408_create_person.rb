class CreatePerson < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :given_name
      t.string :middle_name
      t.string :last_name
      t.string :gender
      t.string :dob
    end
  end
end
