class AddImageFk < ActiveRecord::Migration[6.1]
  def change
    add_reference :images, :users, foreign_key: true
  end
end
