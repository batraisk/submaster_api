ActiveAdmin.register AdminRole, as: "Role" do
  permit_params :name, :admin_managed_resource_ids

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
    column :name
    column "Rights", :admin_managed_resource do |role|
      role.admin_managed_resources.pluck(:action, :name).map {|resource| "#{resource[0]}: #{resource[1]}"}
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row "Rights", :admin_managed_resource do |role|
        role.admin_managed_resources.pluck(:action, :name).map {|resource| "#{resource[0]}: #{resource[1]}"}
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name, input_html: { autocomplete: :off }
      f.input :admin_managed_resource_ids, :as => :check_boxes, :collection => AdminManagedResource.all.map{ |t| [t[:action] +' '+ t[:name], t[:id]]}
    end
    f.actions
  end
end
