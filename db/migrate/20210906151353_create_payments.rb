class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|

      t.string :order_id
      t.string :currency
      t.string :signature
      t.datetime :order_time
      t.string :order_status, null: false, default: "created"
      t.integer :amount
      t.references :user, index: true, foreign_key: true
      t.string :masked_card
      t.string :sender_cell_phone
      t.string :fee
      t.string :reversal_amount
      t.string :settlement_amount
      t.string :actual_amount
      t.string :sender_email
      t.string :actual_currency
      t.string :sender_account
      t.string :card_type
      t.string :card_bin

      t.timestamps
    end
  end
end
