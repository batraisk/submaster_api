class CreateAdminManagedResources < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_managed_resources do |t|
      t.string :class_name, null: false
      t.string :action,     null: false
      t.string :name

      t.timestamps
    end
    add_index :admin_managed_resources, [:class_name, :action, :name], unique: true, name: "admin_managed_resources_index"

  end
end
