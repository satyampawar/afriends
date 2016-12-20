class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :tag_user_id
      t.timestamps null: false
    end
  end
end
