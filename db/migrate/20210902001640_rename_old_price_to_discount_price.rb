class RenameOldPriceToDiscountPrice < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :old_price, :discount_price
  end
end
