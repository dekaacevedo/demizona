class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :old_price
      t.boolean :active
      t.boolean :featured
      t.integer :quantity
      t.integer :user_id
      t.integer :category_id
      t.integer :SKU
      t.integer :store_id
      t.integer :size
      t.string :color
      t.integer :unit_weigth
      t.integer :quantity_stock
      t.booleanrails :discount
      t.string :g
      t.string :model
      t.string :product
      t.string :name
      t.integer :price
      t.integer :old_price
      t.boolean :active
      t.boolean :featured
      t.integer :quantity
      t.integer :user_id
      t.integer :category_id
      t.integer :SKU
      t.integer :store_id
      t.integer :size
      t.string :color
      t.integer :unit_weigth
      t.integer :quantity_stock
      t.boolean :discount

      t.timestamps
    end
  end
end
