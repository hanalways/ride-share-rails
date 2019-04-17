class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  has_many :passengers, :through => :trips

  validates :name, presence: true
  validates :vin, presence: true
  validates :car_make, presence: true
  validates :car_model, presence: true

  def average_rating
    #self is same as driver instance(driver model)
    sum = 0
    self.trips.each do |trip|
      sum += trip.rating
    end
    length = self.trips.length

    if length == 0
      return 0
    end

    average = sum / length
    return average
  end

  #See the driver's total earnings,
  #as defined by the rules in the "Details" section
  #The driver gets 80% of the trip cost after a fee of $1.65 is subtracted
  def total_earnings
    total = 0
    if self.trips.length.zero?
      return 0
    end

    total_earnings = 0
    self.trips.each do |trip|
      total = (trip.cost - 1.65) * 0.8
      total_earnings += total
    end
    return total.round(2)
  end

  # How would they be availble ???
  # need to do the migrations for status: boolean

  def self.available_status
    availability = Driver.where(status: true)
    available_driver = availability.sample
    return available_driver
  end

  def update_status
    return update(status: false)
  end
end
