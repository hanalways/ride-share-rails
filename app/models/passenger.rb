class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  has_many :drivers, :through => :trips
  validates :name, presence: true, format: { with: /\A[a-zA-Z\.\'\-]{2,50}(?: [a-zA-Z\.\'\-]{2,50})+\Z/ }
  validates :phone_num, presence: true

  def total_cost
    if self.trips.length.zero?
      return 0
    end

    total_cost = 0
    self.trips.each do |trip|
      total = trip.cost
      total_cost += total
    end

    total = total_cost / 100
    return total.round(2)
  end
end
