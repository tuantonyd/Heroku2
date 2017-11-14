module ReportingHelper

  def self.state_report(state)
    return Order.where(state_id: state).joins(:order_lines).joins(:items).group(:name).sum('order_lines.qty').sort_by {|_key, value| value}.reverse
  end

  def self.item_popularity
    return OrderLine.select(:qty, :name).joins(:item).group(:name).sum(:qty).sort_by{|_key, value| value}.reverse
  end

  def self.unavailable_inventory
  Item.where(available: false)
  end

  def self.user_total_sales
    return Order.joins(:user).select(:total).group(:user).sum(:total).sort_by{|_key, value| value}.reverse
  end

  def self.orders_by_month
    return Order.group_by_month(:created_at).sum(:total)
  end

  def self.orders_this_week
    return Order.group_by_day(:created_at, range: Time.now.beginning_of_week..Time.now.end_of_week, format: "%a").sum(:total)
  end

  def self.orders_this_year
    return Order.group_by_month(:created_at, range: Time.now.beginning_of_year..Time.now, format: "%b %y").sum(:total)
  end

  def self.orders_this_month
    return Order.group_by_week(:created_at, range: Time.now.beginning_of_month..Time.now, format: "Week of %b %e").sum(:total)
  end
end
