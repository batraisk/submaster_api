class AddPriceToPaymentConfig < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_configs, :ru_price, :integer
    add_column :payment_configs, :en_price, :integer

  end
end
