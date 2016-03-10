class CreatePhotoposts < ActiveRecord::Migration
  def change
    create_table :photoposts do |t|
      t.string :post_id
      t.attachment :photopst

      t.timestamps null: false
    end
  end
end
