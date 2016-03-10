class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :user_id
      t.string :post_name
      t.string :post_type

      t.timestamps null: false
    end
  end
end
