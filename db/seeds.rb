# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = AdminUser.create!(email: 'admin@submaster.com', password: 'password', password_confirmation: 'password')
payment_config = PaymentConfig.instance
payment_config.update(en_price: 3, payment_key: '', ru_price: 3, merchant_id: '')
application_settings = ApplicationSetting.instance
application_settings.update(application_host: '18.190.83.26', support_link: '', privacy_policy: '')
Promocode.create!(amount: 30000, code: 'welcome', begins_at: DateTime.now, ends_at: DateTime.now + 100.years)
ActiveAdmin::ManageableResource.call.each do |manageable_resource|
  unless manageable_resource[:action].eql?('batch_action')
    AdminManagedResource.find_or_create_by!(manageable_resource)
  end
end
admin_role = AdminRole.create!(name: 'Super Admin')
AdminUserAdminRole.create!(admin_role: admin_role, admin_user: admin)
AdminManagedResource.all.each do |resource|
  @admin_permission = AdminPermission.create!(admin_managed_resource: resource, admin_role: admin_role)
end