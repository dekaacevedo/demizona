class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  before_save :set_item_price
  before_save :set_total

  def item_price
    if persisted?
      self[:item_price]
    else
      if product.discount
        product.discount_price
      else
        product.price
      end
    end
  end

  def total
    return item_price * quantity
  end

  private

  def set_item_price
    self[:item_price] = item_price
  end

  def set_total
    self[:total] = total * quantity
  end
end
