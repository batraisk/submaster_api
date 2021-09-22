class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :page, null: true
      t.references :product, polymorphic: true
      t.string :kind, null: false, default: "subscribe"
      t.integer :amount
      t.timestamps
    end
  end
end
