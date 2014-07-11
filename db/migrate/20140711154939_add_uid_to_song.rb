class AddUidToSong < ActiveRecord::Migration
  def change
    add_column :songs, :uuid, :string
  end
end
