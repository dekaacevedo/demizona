class User < ApplicationRecord
  has_many :stores, dependent: :destroy
  has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy

  def make_it_a_seller!
    self.seller = true
  end

  def make_it_a_not_seller!
    self.seller = false
  end
end
