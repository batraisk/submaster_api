ActiveAdmin.register ApplicationSetting do
  # actions = current_admin_user.available_actions('ApplicationSetting')
  menu :label => "Application Settings"#, :if => proc{ false }
  # actions :all
  actions :all, :except => [:new, :destroy]
  # actions []
  permit_params :application_host, :support_link, :privacy_policy


  index do
    column :application_host if false
    column :support_link
    column :privacy_policy
    actions
  end

  show do
    attributes_table do
      row :application_host
      row :support_link
      row :privacy_policy
    end
  end


  form do |f|
    f.inputs do
      f.input :application_host
      f.input :support_link
      f.input :privacy_policy
    end
    f.actions
  end
end