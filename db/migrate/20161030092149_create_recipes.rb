class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :recipeId
      t.string :title
      t.string :source_url
      t.string :image_url
      t.text :ingredients
      t.bigint :view, default: 0

      t.timestamps null: false
    end
  end
end
