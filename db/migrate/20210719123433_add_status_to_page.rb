class AddStatusToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :status, :string, default: "inactive"
  end
end
