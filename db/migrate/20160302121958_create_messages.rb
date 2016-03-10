class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :conversation_id
      t.string :user_id
      t.string :integer

      t.timestamps null: false
    end
  end
end
