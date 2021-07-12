ActiveAdmin.register InstagramCredential do
  permit_params :login, :password

  index do
    selectable_column
    id_column
    column :login
    actions
  end

  filter :login
  filter :created_at

  form do |f|
    f.inputs do
      f.input :login
      f.input :password
    end
    f.actions
  end

end
