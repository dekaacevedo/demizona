class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_item, dependent: :destroy
  has_many :product, :through :cart_item
end
