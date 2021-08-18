class Product < ApplicationRecord
  belongs_to :store
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  validates :name, presence: true, length: { in: 2..30 }
  validates :description, length: { maximum: 1000 }
  validates :old_price, presence: true
  validates :sku, presence: true, uniqueness: true

end
