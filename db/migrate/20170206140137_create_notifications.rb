class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :notifier_id
      t.string :notification_type
      t.boolean :is_read , :default => false
      t.timestamps null: false
    end
  end
end
