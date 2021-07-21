class AddStatusToDomain < ActiveRecord::Migration[6.1]
  def change
    add_column :domains, :status, :string
  end
end
