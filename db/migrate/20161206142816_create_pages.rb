class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :page_type
      t.integer :user_id
      t.string :title
      t.boolean :is_publish
      t.timestamps null: false
      t.integer :user_id
    end
  end
end
