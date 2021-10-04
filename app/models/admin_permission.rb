# == Schema Information
#
# Table name: admin_permissions
#
#  id                        :bigint           not null, primary key
#  state                     :integer          default(0), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  admin_managed_resource_id :integer          not null
#  admin_role_id             :integer          not null
#
# Indexes
#
#  admin_permissions_index  (admin_managed_resource_id,admin_role_id) UNIQUE
#
class AdminPermission < ApplicationRecord
  belongs_to :admin_managed_resource
  belongs_to :admin_role
end
