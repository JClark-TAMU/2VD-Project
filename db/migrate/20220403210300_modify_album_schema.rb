class ModifyAlbumSchema < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :caption, :string
  end
end
