class CreateLogins < ActiveRecord::Migration[6.1]
  def change
    create_table :logins do |t|
      t.string :name, null: false
      t.string :status, null: false, default: "not_subscribed"

      t.references :page, index: true, foreign_key: true
      t.timestamps
    end
  end
end
