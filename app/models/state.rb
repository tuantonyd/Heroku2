class State < ApplicationRecord
  has_many :orders
  has_many :customers
  
end
