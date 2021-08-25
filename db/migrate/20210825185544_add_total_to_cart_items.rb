class AddTotalToCartItems < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :total, :integer
  end
end
