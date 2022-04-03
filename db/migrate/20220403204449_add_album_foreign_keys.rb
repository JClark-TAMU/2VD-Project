class AddAlbumForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_reference :Album, :user, foreign_key: true
    add_reference :Album, :portfolio, foreign_key: true
  end
end
