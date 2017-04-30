class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
  
      t.integer :user_id
      t.integer :post_id
      t.text :comment_name
      t.attachment :comment_pic
      t.timestamps null: false
    end
  end
end
