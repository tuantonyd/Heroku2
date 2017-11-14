class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.boolean :available, null: false, default: true
      t.timestamps
    end
  end
end
