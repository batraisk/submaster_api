class AddCountryToUserInfo < ActiveRecord::Migration[6.1]
  def change
    add_column :user_infos, :country, :string, default: "RU"
  end
end
