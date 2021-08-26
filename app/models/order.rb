class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user

  STATUSES = {
    in_process: "En proceso",
    rejected: "Rechazada",
    payed: "Pagada",
    on_delivery: "En tránsito",
    completed: "Completada"
  }

  before_create :set_status

  private
  
  def set_status
    self.status = STATUSES[:payed]
  end
end
