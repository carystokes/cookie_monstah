class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  validates :title, presence: true
  validates :ingredients, presence: true
  validates :instructions, presence: true

  def self.search(search)
    if search
      where("title ILIKE ?", "%#{search}%")
      where("ingredients ILIKE ?", "%#{search}%")
      where("instructions ILIKE ?", "%#{search}%")
    else
      find(:all)
    end
  end
end
