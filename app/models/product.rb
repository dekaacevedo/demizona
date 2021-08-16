class Product < ApplicationRecord
  has_many :cart_item, dependent: :destroy
  has_many :cart, :through :cart_item
end
