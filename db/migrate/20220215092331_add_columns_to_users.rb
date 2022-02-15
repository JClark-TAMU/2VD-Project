class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :avatar, :string
    remove_column :users, :password, :string
  end
end
