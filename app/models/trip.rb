class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  validates :rating, in: (1..5), allow_nil: true
end
