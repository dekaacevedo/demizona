class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.boolean :active
      t.integer :total_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
