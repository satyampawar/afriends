class CreatePageMovies < ActiveRecord::Migration
  def change
    create_table :page_movies do |t|
      t.integer :movie_id
      t.string :title
      t.string :plot_summary
      t.string :video_url
      t.string :poster_url
      t.string :director
      t.decimal :rating
      t.string :year
      t.string :release_date
      t.references :page
      t.timestamps null: false
    end
  end
end
