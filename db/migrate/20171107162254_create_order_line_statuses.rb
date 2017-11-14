class CreateOrderLineStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :order_line_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
