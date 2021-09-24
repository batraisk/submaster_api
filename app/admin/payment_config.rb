ActiveAdmin.register PaymentConfig do
  actions :all, :except => [:new, :destroy]

  index do
    column :merchant_id
    column :payment_key
    column :ru_price
    column :en_price
    actions
  end
end