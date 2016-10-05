class Recipe < ActiveRecord::Base
  include PgSearch

  belongs_to :user
  has_many :reviews

  validates :title, presence: true
  validates :ingredients, presence: true
  validates :instructions, presence: true

  pg_search_scope :search,
    against: [:title, :ingredients, :instructions, :description],
    using: {tsearch: {prefix: true, dictionary: "english"}}

  # def self.search(search)
  #   if search
  #     where("title ILIKE ?", "%#{search}%")
  #     where("ingredients ILIKE ?", "%#{search}%")
  #     where("instructions ILIKE ?", "%#{search}%")
  #   else
  #     find(:all)
  #   end
  # end
end
