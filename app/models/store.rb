class Store < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :name, presence: true,  length: { in: 2..30 }
  validates :address, presence: true
  validates :city, presence: true,  length: { in: 2..30 }
  validates :email, presence: true, format: { with: /^[\w|-]+@[\w|-]+\.\w+$/ }
  validates :phone, presence: true, length: { minimum: 9 }, numericality: { only_integer: true }
end
