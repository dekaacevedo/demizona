class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart

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
