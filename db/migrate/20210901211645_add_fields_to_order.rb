class AddFieldsToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :payment_id, :string
    add_column :orders, :paid, :boolean, default: false
  end
end
