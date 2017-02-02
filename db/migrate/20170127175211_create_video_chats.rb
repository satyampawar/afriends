class CreateVideoChats < ActiveRecord::Migration
  def change
    create_table :video_chats do |t|
      t.integer :caller_id
      t.integer :receiver_id
      t.string :token_base

      t.timestamps null: false
    end
  end
end
