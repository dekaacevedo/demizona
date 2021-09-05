require 'khipu-api-client'

Khipu.configure do |c|
  c.secret = ENV['KHIPU_SECRET']
  c.receiver_id = 398159
  c.platform = 'demo-client'
  c.platform_version = '2.0'
  c.debugging = true
end
