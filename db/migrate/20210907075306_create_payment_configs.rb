class CreatePaymentConfigs < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_configs do |t|
      t.integer :singleton_guard
      t.string :merchant_id
      t.string :payment_key
      t.index :singleton_guard, :unique => true

      t.timestamps
    end
  end
end
