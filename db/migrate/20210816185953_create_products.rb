class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :old_price
      t.boolean :active, default: false
      t.boolean :featured, default: false
      t.integer :quantity
      t.integer :sku
      t.integer :size
      t.string :color
      t.integer :unit_weight
      t.integer :quantity_stock
      t.boolean :discount, default: false

      t.timestamps
    end
  end
end
