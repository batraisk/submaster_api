class ChangeDefaultStatusOfPage < ActiveRecord::Migration[6.1]
  def change
    change_column :pages, :status, :string, default: 'active'
  end
end
