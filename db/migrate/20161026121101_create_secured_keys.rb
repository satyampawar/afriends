class CreateSecuredKeys < ActiveRecord::Migration
  def change
    create_table :secured_keys do |t|
      t.text :salt
      t.text :key
      t.integer :document_id

      t.timestamps null: false
    end
  end
end
