class AddGalleriesToImages < ActiveRecord::Migration[6.1]
  def change
    add_reference :images, :galleries, optional: true, foreign_key: true
  end
end
