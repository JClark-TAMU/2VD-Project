class AddImageToAlbumFk < ActiveRecord::Migration[6.1]
  def change
    add_reference :images, :albums, optional: true, foreign_key: true
  end
end
