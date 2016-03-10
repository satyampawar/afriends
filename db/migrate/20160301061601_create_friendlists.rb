class CreateFriendlists < ActiveRecord::Migration
  def change
    create_table :friendlists do |t|
      t.string :user_id
      t.string :friend_id
      t.string :blockstatus

      t.timestamps null: false
    end
  end
end
