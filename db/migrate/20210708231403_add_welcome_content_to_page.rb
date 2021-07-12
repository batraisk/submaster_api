class AddWelcomeContentToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :welcome_content, :text
  end
end
