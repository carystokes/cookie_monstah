class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :value, numericality: { only_integer: true },
    inclusion: { in: -1..1 }
end
