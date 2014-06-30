class AddGenreToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :genre, :string
  end
end
