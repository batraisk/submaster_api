class CreateUserPromocodes < ActiveRecord::Migration[6.1]
  def change
    create_table :user_promocodes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :promocode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
