class Order < ApplicationRecord
  belongs_to :order_status
  has_many :order_lines
  belongs_to :user
  belongs_to :state
  has_many :items, through: :order_lines
  after_initialize :def_values
  after_find :check_order_lines
  accepts_nested_attributes_for :order_lines

  self.per_page = 5

  def def_values
    logger.warn("DEFVALUES DEF VALUES")
    @orderstatus = OrderStatus.find_by(status: 'Placed')
    logger.warn(@orderstatus)

    self.order_status ||= @orderstatus
  end

  def check_order_lines
    logger.warn "Checking order content/line statuses"
    total_orders = self.order_lines.size
    orders_completed = self.order_lines.where(order_line_status_id: 3).size
    orders_started = self.order_lines.where(order_line_status_id: 2).size
    logger.warn("Number of order lines in order: #{total_orders}" )
    logger.warn("Number of completed order lines in order: #{orders_completed}" )
    logger.warn("Both number are equal? #{total_orders == orders_completed}")

    if total_orders == orders_completed
      self.update(order_status_id: 3)
    elsif orders_started > 0
      self.update(order_status_id: 2)
    elsif self.order_status_id != 1
      self.update(order_status_id: 1)
    end
  end
end
