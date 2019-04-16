class Driver < ApplicationRecord
  has_many :trips   # plural
  has_many :passengers, :through => :trips

  validates :name, presence: true
  validates :vin, presence: true

  def average_rating
    #self is same as driver instance(driver model)
    sum = 0
    self.trips.each do |trip|
      sum = sum + trip.rating
    end
    length = self.trips.length

    if length == 0
      return 0
    end

    average = sum / length
    return average
  end
end
