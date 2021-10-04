class CreateAdminPermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_permissions do |t|
      t.integer :admin_managed_resource_id, null: false
      t.integer :admin_role_id,             null: false
      t.integer :state,                     null: false, limit: 1, default: 0
      t.timestamps
    end

    add_index :admin_permissions, [:admin_managed_resource_id, :admin_role_id], unique: true, name: "admin_permissions_index"

  end
end
