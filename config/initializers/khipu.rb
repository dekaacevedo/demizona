require 'khipu-api-client'

Khipu.configure do |c|
  c.secret = 'c4d19d1b93c0cc90fd20163f9b279f90ad5f9181'
  c.receiver_id = 398159
  c.platform = 'demo-client'
  c.platform_version = '2.0'
  c.debugging = true
end
