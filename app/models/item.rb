class Item < ApplicationRecord
  has_many :item_images, :dependent => :destroy
  validates_presence_of :name, :price
  validate :item_price_validation

  def item_price_validation
    if price < 0
      self.errors.add(:price, "Item price cannot be negative")
    end
  end


end
