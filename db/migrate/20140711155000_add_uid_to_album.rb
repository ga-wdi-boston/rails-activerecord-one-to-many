class AddUidToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :uuid, :string
  end
end
