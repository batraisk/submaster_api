class AddFieldsToGuest < ActiveRecord::Migration[6.1]
  def change
    add_column :guests, :remote_ip, :string
    add_column :guests, :user_agent, :string

  end
end
