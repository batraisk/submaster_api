class CreateInstagramCredentials < ActiveRecord::Migration[6.1]
  def change
    create_table :instagram_credentials do |t|
      t.string :login, null: false
      t.string :password, null: false

      t.timestamps
    end
  end
end
