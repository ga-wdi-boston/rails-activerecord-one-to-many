class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :name
    end
  end
end
