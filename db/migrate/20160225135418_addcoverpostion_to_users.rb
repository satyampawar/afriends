class AddcoverpostionToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :coverpos, :decimal
  end
end
