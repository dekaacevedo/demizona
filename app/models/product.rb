class Product < ApplicationRecord
  belongs_to :store
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many_attached :photos

  validates :name, presence: true, length: { in: 2..30 }
  validates :description, length: { maximum: 1000 }
  validates :price, presence: true
  validates :sku, presence: true, uniqueness: true

end
