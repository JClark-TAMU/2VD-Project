class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.boolean :isAdmin
      t.string :role
      t.string :bio
      t.integer :portfolioID

      t.timestamps
    end
  end
end
