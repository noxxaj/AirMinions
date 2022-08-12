class Minion < ApplicationRecord
  belongs_to :user
  has_many :users, through: :bookings
  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :price_per_day, presence: true
  validates :price_per_day, numericality: true
  validates :name, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_and_skills,
    against: [ :name, :skills ],
    using: {
      tsearch: { prefix: true }
    }
end
