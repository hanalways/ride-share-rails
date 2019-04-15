class Driver < ApplicationRecord
  has_many :trips   # plural
  has_many :passengers, :through => :trips
end
