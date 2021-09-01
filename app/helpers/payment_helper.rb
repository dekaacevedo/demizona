module PaymentHelper
  def create_new_payment(total_price)
    client = Khipu::PaymentsApi.new
    response = client.payments_post('Motivo del cobro', 'CLP', total_price, {
        transaction_id: 'FACT2001',
        expires_date: 10.days.from_now.to_datetime,
        body: 'Descripción de la compra',
        picture_url: 'http://mi-ecomerce.com/pictures/foto-producto.jp',
        return_url: 'http://mi-ecomerce.com/backend/return',
        cancel_url: 'http://mi-ecomerce.com/backend/cancel',
        notify_url: 'http://mi-ecomerce.com/backend/notify',
        notify_api_version: '1.3'
    })
    return response
  end
end
