class AddInstaAvatarToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :insta_avatar, :string

  end
end
