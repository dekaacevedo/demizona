class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :old_price
      t.boolean :active, default: false
      t.boolean :featured, default: false
      t.integer :sku
      t.string :unit_type
      t.integer :quantity_stock
      t.boolean :discount, default: false
      t.text :description
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
