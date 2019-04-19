class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  validates :rating, numericality: { greater_than: 0, less_than: 6 }, allow_nil: true
end
