class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :user_id
      t.string :album_id
      t.attachment :pic
      t.boolean :hide

      t.timestamps null: false
    end
  end
end
