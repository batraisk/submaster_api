class CreatePromocodes < ActiveRecord::Migration[6.1]
  def change
    create_table :promocodes do |t|
      t.string :code
      t.string :kind, null: false, default: "currency"
      t.datetime :begins_at
      t.datetime :ends_at
      t.integer :duration
      t.integer :amount

      t.timestamps
    end
  end
end
