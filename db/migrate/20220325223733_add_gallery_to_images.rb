class AddGalleryToImages < ActiveRecord::Migration[6.1]
  def change
    add_reference :images, :gallery, optional: true, foreign_key: true
  end
end
