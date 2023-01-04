class RemoveArtistFromAlbum < ActiveRecord::Migration[6.1]
  def change
    remove_column :albums, :artist
  end
end
