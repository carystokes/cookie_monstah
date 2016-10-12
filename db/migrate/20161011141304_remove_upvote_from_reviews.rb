class RemoveUpvoteFromReviews < ActiveRecord::Migration
  def up
    remove_column :reviews, :upvotes
    remove_column :reviews, :downvotes
  end

  def down
    add_column :reviews, :upvotes, :integer, default: 0
    add_column :reviews, :downvotes, :integer, default: 0
  end
end
