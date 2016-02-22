class AddOwnerToPet < ActiveRecord::Migration
  def change
    add_column :pets, :owner_id, :integer
    add_foreign_key :pets, :people,
                    column: :owner_id, index: true, foreign_key: true
  end
end
