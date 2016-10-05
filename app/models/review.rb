class Review < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user

  validates :rating, numericality: {only_integer: true},
  inclusion: {in: 1..5, message: "Rating must be between 1 - 5"}
end