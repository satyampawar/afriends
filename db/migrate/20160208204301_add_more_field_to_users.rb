class AddMoreFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :worked_at, :string
    add_column :users, :collage, :string
    add_column :users, :school, :string
    add_column :users, :llves, :string
    add_column :users, :hometown, :string
    add_column :users, :nickname, :string
    add_column :users, :img_url, :string
  end
end
