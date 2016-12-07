class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :page_type
      t.integer :user_id
      t.string :title

      t.timestamps null: false
    end
  end
end
