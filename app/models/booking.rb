class Booking < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :minion, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
end
