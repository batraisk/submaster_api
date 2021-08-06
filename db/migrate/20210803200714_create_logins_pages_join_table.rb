class CreateLoginsPagesJoinTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :logins, :page_id
    create_join_table :logins, :pages do |t|
      t.index :login_id
      t.index :page_id
    end
  end
end
