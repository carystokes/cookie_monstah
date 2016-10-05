class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  validates :title, presence: true
  validates :ingredients, presence: true
  validates :instructions, presence: true

  def self.search(search)
    where("title LIKE ? OR ingredients LIKE ? OR instructions LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
  end
end
