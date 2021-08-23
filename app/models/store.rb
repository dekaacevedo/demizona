class Store < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :name, presence: true,  length: { in: 2..30 }
  validates :address, presence: true
  validates :city, presence: true,  length: { in: 2..30 }
  validates :email, presence: true, format: { with: /\A[\w|.|-]+@[\w|-]+\.\w+\z/ }
  validates :phone, presence: true, length: { minimum: 9 } #numericality: { only_integer: true }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
