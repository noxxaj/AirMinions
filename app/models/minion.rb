class Minion < ApplicationRecord
  belongs_to :user
  has_many :users, through: :bookings

  validates :price_per_day, presence: true
  validates :price_per_day, numericality: true
  validates :name, presence: true
end
