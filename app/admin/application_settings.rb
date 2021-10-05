ActiveAdmin.register ApplicationSetting do#, as: I18n.t("subject.application_settings") do
  # actions = current_admin_user.available_actions('ApplicationSetting')
  # menu :label => I18n.t("subject.application_settings")#, :if => proc{ false }
  # actions :all
  actions :all, :except => [:new, :destroy]
  # actions []
  permit_params :application_host, :support_link, :privacy_policy, :online_course_link


  index do
    column I18n.t("attribute.application_setting.application_host"), :application_host
    column I18n.t("attribute.application_setting.support_link"), :support_link
    # column :privacy_policy
    column I18n.t("attribute.application_setting.online_course_link"), :online_course_link
    actions
  end

  show do
    attributes_table do
      row I18n.t("attribute.application_setting.application_host"), :application_host
      row I18n.t("attribute.application_setting.support_link"), :support_link
      # row :privacy_policy
      row I18n.t("attribute.application_setting.online_course_link"), :online_course_link
    end
  end


  form do |f|
    f.inputs do
      f.input :application_host, label: I18n.t("attribute.application_setting.application_host")
      f.input :support_link, label: I18n.t("attribute.application_setting.support_link")
      # f.input :privacy_policy
      f.input :online_course_link, label: I18n.t("attribute.application_setting.online_course_link")
    end
    f.actions
  end
end