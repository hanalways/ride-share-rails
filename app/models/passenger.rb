class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  has_many :drivers, :through => :trips
  validates :name, presence: true, format: { with: /\A[a-zA-Z\.\'\-]{2,50}(?: [a-zA-Z\.\'\-]{2,50})+\Z/ }
  validates :phone_num, presence: true

  def total_cost
    if self.trips.length.zero?
      return 0
    else
      total = self.trips.sum do |trip|
        trip.cost
      end
      return (total/100).round(2)
    end
  end
end
