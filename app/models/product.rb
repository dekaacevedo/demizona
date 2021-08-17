class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :carts, :through :cart_items
  has_many :product_categories, dependent: :destroy
  has_many :categories, :through :product_categories
end
