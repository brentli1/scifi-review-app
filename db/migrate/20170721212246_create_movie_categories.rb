class CreateMovieCategories < ActiveRecord::Migration
  def change
    create_table :movie_categories do |t|
      t.integer :movie_id
      t.integer :category_id
    end
  end
end
