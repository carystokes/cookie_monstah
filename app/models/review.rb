class Review < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  has_many :votes

  validates :rating, numericality: {only_integer: true},
  inclusion: { in: 1..5, message: 'must be between 1 - 5' }
end
