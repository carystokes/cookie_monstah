class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.text :ingredients, null: false
      t.text :instructions, null: false
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
