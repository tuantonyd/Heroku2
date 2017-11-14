class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.numeric :total
      t.text :notes
      t.references :user, foreign_key: true
      t.references :order_status, foreign_key: true
      t.string :address
      t.string :city
      t.references :state, foreign_key: true
      t.references :country, foreign_key: true
      t.integer :zip
      t.string :stripe_key
      t.timestamps
    end
  end
end
