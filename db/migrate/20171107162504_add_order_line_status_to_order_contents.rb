class AddOrderLineStatusToOrderContents < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_lines, :order_line_status, foreign_key: true
  end
end
