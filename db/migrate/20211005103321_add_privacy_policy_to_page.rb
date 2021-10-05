class AddPrivacyPolicyToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :privacy_policy, :string, default: ''
  end
end
