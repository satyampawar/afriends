class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :user_id
      t.string :album_name
      t.string :status
      t.boolean :hide

      t.timestamps null: false
    end
  end
end
