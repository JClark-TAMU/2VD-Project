class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.string :title
      t.string :caption
      t.boolean :showOnPortfolio
      t.string :imageLink
      t.timestamps
    end
  end
end
