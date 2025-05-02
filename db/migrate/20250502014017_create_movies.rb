class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.text :summary
      t.integer :restrict, null: false, default: 0
      t.float :rating
      t.integer :published_year
      t.string :director_name, null: false, default: ""
      t.integer :to_favorite_registered_count, null: false, default: 0

      t.timestamps

      t.index :title
    end
  end
end
