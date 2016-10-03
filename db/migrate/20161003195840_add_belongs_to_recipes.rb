class AddBelongsToRecipes < ActiveRecord::Migration
  def up
    add_column :recipes, :user_id, :integer
    change_column_null :recipes, :user_id, false
  end

  def down
    remove_column :recipes, :user_id
  end
end
