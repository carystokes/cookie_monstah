class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  validates :title, presence: true
  validates :ingredients, presence: true
  validates :instructions, presence: true
end
