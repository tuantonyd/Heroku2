class AddQuantityFulfilledToOrderLine < ActiveRecord::Migration[5.1]
  def change
    add_column :order_lines, :quantity_fulfilled, :integer
  end
end
