class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :user
      t.string :user_agent
      t.string :endpoint, null: false
      t.string :p256dh
      t.string :auth
      t.timestamps null: false
    end
  end
end
