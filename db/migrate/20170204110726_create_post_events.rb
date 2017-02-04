class CreatePostEvents < ActiveRecord::Migration
  def change
    create_table :post_events do |t|
    	t.integer :post_id
    	t.integer :page_id
      t.string :event_type
      t.string :event_string
      t.string :event_stage1
      t.string :event_stage2
      t.string :event_stage3
      t.timestamps null: false
    end
  end
end
