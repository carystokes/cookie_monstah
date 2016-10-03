class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  validates :title, presence: true
  validates :instructions, presence: true
  validates :ingredients, presence: true
end
