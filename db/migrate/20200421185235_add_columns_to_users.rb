class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string 
    add_column :users, :last_name, :string 
    add_column :users, :user_name, :string, null: false
    add_column :users, :admin, :boolean, null: false, default: false

    add_index :users, :user_name, unique: true
  end  
end
