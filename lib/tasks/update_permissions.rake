namespace :active_admin do
  desc "Upload permissions list"
  task update_permissions: :environment do
    ActiveAdmin::ManageableResource.call.each do |manageable_resource|
      unless manageable_resource[:action].eql?('batch_action')
        AdminManagedResource.find_or_create_by!(manageable_resource)
      end
    end
  end
end
