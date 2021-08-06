class AddYoutubeToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :youtube, :string
  end
end
