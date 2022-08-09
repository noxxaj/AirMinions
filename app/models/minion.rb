class Minion < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :users, through: :bookings
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :price_per_day, presence: true
  validates :price_per_day, numericality: true
  validates :name, presence: true
end
