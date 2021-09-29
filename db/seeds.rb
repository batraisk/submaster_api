# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@submaster.com', password: 'password', password_confirmation: 'password')
payment_config = PaymentConfig.instance
payment_config.update(en_price: 3, payment_key: '', ru_price: 3, merchant_id: '')
application_settings = ApplicationSetting.instance
application_settings.update(application_host: '18.190.83.26', support_link: '', privacy_policy: '')

