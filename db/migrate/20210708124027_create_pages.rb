class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.string :page_name
      t.string :url
      t.string :instagram_login
      t.string :facebook_pixel_id
      t.string :facebook_server_side_token
      t.string :yandex_metrika

      t.string :welcome_title
      t.text :welcome_description
      t.string :welcome_button_text
      t.integer :timer_time
      t.boolean :timer_enable
      t.string :timer_text

      t.string :layout
      t.string :theme

      t.string :success_title
      t.text :success_description
      t.string :success_button_text
      t.string :download_link

      t.string :out_of_stock_title
      t.text :out_of_stock_description

      t.references :user, index: true, foreign_key: true
      t.references :domain, index: true, foreign_key: true

      t.timestamps

    end
  end
end
