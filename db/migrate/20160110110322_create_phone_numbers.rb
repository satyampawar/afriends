class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :mobile_number
      t.string :pin
      t.boolean :verified

      t.timestamps null: false
    end
  end
end
