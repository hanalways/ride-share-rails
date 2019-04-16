class Passenger < ApplicationRecord
  has_many :trips
  has_many :drivers, :through => :trips
  validates :name, presence: true, format: {with: /\A[a-zA-Z\.\'\-]{2,50}(?: [a-zA-Z\.\'\-]{2,50})+\Z/}
  validates :phone_num, presence: true, numericality: true, length: { is: 7 }
end
