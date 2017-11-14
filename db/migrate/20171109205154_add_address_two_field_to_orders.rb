class AddAddressTwoFieldToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :address_two, :string
  end
end
