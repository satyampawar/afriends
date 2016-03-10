class CreateFriendlogs < ActiveRecord::Migration
  def change
    create_table :friendlogs do |t|
      t.string :user_id
      t.string :friend_id
      t.string :status

      t.timestamps null: false
    end
  end
end
