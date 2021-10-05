ActiveAdmin.register AdminRole, as: "Role" do
  permit_params :name, :admin_managed_resource_ids
  before_filter :skip_sidebar!, :only => :index
  controller do
    def update
      @admin_role = AdminRole.find(params[:id])
      @admin_role.update(name: params[:admin_role][:name])
      @resources = AdminManagedResource.where(id: params[:admin_role][:admin_managed_resource_ids])
      AdminPermission.where(admin_role: @admin_role).destroy_all
      @resources.each do |resource|
        @admin_permission = AdminPermission.create(admin_managed_resource: resource, admin_role: @admin_role)
      end
      redirect_to :admin_roles
    end

    def create
      @admin_role = AdminRole.create(name: params[:admin_role][:name])
      @resources = AdminManagedResource.where(id: params[:admin_role][:admin_managed_resource_ids])
      AdminPermission.where(admin_role: @admin_role).destroy_all
      @resources.each do |resource|
        @admin_permission = AdminPermission.create(admin_managed_resource: resource, admin_role: @admin_role)
      end
      redirect_to :admin_roles
    end

    def destroy
      @admin_role = AdminRole.find(params[:id])
      if @admin_role.name == 'Super Admin'
        flash[:error] = "Error(s) : Role Super Admin cannot be deleted"
        redirect_back(fallback_location: @admin_role)
      else
        AdminPermission.where(admin_role: @admin_role).destroy_all
        @admin_role.destroy
        redirect_to :admin_roles
      end

    end
  end

  index do
    selectable_column
    id_column
    column I18n.t("activerecord.models.role.one"), :name
    column I18n.t("attribute.rights"), :admin_managed_resource do |role|
      role.admin_managed_resources.pluck(:action, :name).map {|resource| "#{I18n.t("actions.#{resource[0]}")}: #{I18n.t("activerecord.models.#{resource[1].underscore}.one")}"}
    end
    actions
  end

  show do
    attributes_table do
      row I18n.t("activerecord.models.role.one"), :name
      row I18n.t("attribute.rights"), :admin_managed_resource do |role|
        role.admin_managed_resources.pluck(:action, :name).map {|resource| "#{I18n.t("actions.#{resource[0]}")}: #{I18n.t("activerecord.models.#{resource[1].underscore}.one")}"}
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name, input_html: { autocomplete: :off }, label: I18n.t("activerecord.models.role.one")
      f.input :admin_managed_resource_ids, label: I18n.t("attribute.rights"), :as => :check_boxes, :collection => AdminManagedResource.all.map { |t| [ I18n.t("actions.#{t[:action]}") + ' ' + I18n.t("activerecord.models.#{t[:name].underscore}.one"), t[:id]] }
        # return [I18n.t("actions.#{t[:action]}") +' '+ t[:name], t[:id]]

    end
    f.actions
  end
end
