class AdminColumn < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
  end
end
