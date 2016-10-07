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
end
