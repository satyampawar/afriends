class AddEmotionAndFlagToLikes < ActiveRecord::Migration
  def change
  	add_column :likes, :emotion, :string
    add_column :likes, :flag, :boolean
  end
end
