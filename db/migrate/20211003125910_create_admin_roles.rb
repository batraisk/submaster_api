class CreateAdminRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_roles do |t|
      t.string :name, nil: false

      t.timestamps
    end
  end
end
