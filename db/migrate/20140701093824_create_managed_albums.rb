class CreateManagedAlbums < ActiveRecord::Migration
  def change
    create_table :managed_albums do |t|
      t.belongs_to :user, index: true
      t.belongs_to :album, index: true
      t.string :role

      t.timestamps
    end
  end
end
