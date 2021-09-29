class CreateApplicationSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :application_settings do |t|
      t.integer :singleton_guard
      t.string :application_host
      t.string :support_link
      t.string :privacy_policy
      t.index :singleton_guard, :unique => true

      t.timestamps
    end
  end
end
