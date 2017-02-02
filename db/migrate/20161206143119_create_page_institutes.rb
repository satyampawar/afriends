class CreatePageInstitutes < ActiveRecord::Migration
  def change
    create_table :page_institutes do |t|
      t.decimal :lats
      t.decimal :long
      t.text :address
      t.references :page
      t.attachment :picture
      t.string :about
      t.string :country

      t.timestamps null: false
    end
  end
end
