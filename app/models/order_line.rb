class OrderLine < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :order_line_status
  has_one :state, through: :order
  after_find :check_status

  def check_status
    if self.order_line_status_id == 1
      self.update(quantity_fulfilled: 0)
    elsif self.order_line_status_id == 3
      self.update(quantity_fulfilled: self.qty)
    end
  end
end
