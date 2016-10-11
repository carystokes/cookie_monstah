class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  has_many :recipes
  has_many :reviews
  has_many :votes
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
