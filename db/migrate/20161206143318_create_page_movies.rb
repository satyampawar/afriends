class CreatePageMovies < ActiveRecord::Migration
  def change
    create_table :page_movies do |t|
      t.string :url
      t.integer :imdb_id
      t.references :page
      t.timestamps null: false
    end
  end
end
