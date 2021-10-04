ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :admin_role_ids

  controller do
    def update
      @admin_user = AdminUser.find(params[:id])
      update_method = params[:admin_user][:password].present? ? :update_attributes : :update_without_password
      @admin_user.send(update_method, user_params)
      @admin_roles = AdminRole.where(id: params[:admin_user][:admin_role_ids])
      AdminUserAdminRole.where(admin_user: @admin_user).destroy_all
      @admin_roles.each do |role|
        AdminUserAdminRole.create(admin_user: @admin_user, admin_role: role)
      end
      redirect_to :admin_admin_users
    end

    def create
      @admin_user = AdminUser.new(user_params)
      if @admin_user.save
        @admin_roles = AdminRole.where(id: params[:admin_user][:admin_role_ids])

        @admin_roles.each do |role|
          AdminUserAdminRole.create(admin_user: @admin_user, admin_role: role)
        end
        redirect_to :admin_admin_users
      else
        flash[:error] = "Error(s) : #{resource.errors.full_messages.join(',')}"
        redirect_to :new_admin_admin_user
      end
    end

    def destroy
      @admin_user = AdminUser.find(params[:id])
      AdminUserAdminRole.where(admin_user: @admin_user).destroy_all
      @admin_user.destroy
      redirect_to :admin_admin_users
    end

    def user_params
      params.require(:admin_user).permit(:email, :password, :password_confirmation)
    end
  end

  index do
    selectable_column
    id_column
    column :email
    # column :current_sign_in_at
    column :created_at
    column "Roles", :admin_roles do |user|
      user.admin_roles.map {|role| role[:name]}
    end
    actions
  end

  show do
    attributes_table do
      row :email
      row :created_at
      row :updated_at
      row "Roles", :admin_roles do |user|
        user.admin_roles.map {|role| role[:name]}
      end
    end
  end

  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :admin_roles, :as => :check_boxes, :collection => AdminRole.all.map{ |t| [t[:name], t[:id]]}
    end
    f.actions
  end
end
