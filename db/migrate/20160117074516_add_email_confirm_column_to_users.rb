class AddEmailConfirmColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_verify, :boolean , :default => false
    add_column :users, :confirm_token, :string
  end
end
