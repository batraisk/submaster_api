ActiveAdmin.register PaymentConfig do
  actions :all, :except => [:new, :destroy]
  permit_params :en_price, :payment_key, :ru_price, :merchant_id

  index do
    column :merchant_id
    column :payment_key
    column :ru_price
    column :en_price
    actions
  end

  form do |f|
    f.inputs do
      f.input :payment_key
      f.input :merchant_id
      f.input :ru_price, label: "Price for Russia"
      f.input :en_price, label: "Price for Others"
    end
    f.actions
  end
end