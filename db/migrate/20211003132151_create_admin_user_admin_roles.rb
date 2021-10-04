class CreateAdminUserAdminRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_user_admin_roles do |t|
      t.integer :admin_user_id, null: false
      t.integer :admin_role_id, null: false
      t.timestamps
    end
  end
end
