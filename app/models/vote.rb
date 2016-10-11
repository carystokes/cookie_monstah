class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :value, numericality: { only_integer: true },
    inclusion: { in: -1..1 }
end
