class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  validates :ingredients, presence: true
  validates :title, presence: true
  validates :instructions, presence: true
end
