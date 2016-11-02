class AddColumnToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :locked, :string, default: "No"
    add_column :albums, :pin, :string
  end
end
