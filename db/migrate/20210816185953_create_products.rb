class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :old_price
      t.boolean :active, default: false
      t.boolean :featured, default: false
      t.integer :sku
      t.string :size
      t.string :color
      t.string :unit_type
      t.integer :quantity_stock
      t.boolean :discount, default: false

      t.timestamps
    end
  end
end
