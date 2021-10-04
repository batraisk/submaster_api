# == Schema Information
#
# Table name: admin_user_admin_roles
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  admin_role_id :integer          not null
#  admin_user_id :integer          not null
#
class AdminUserAdminRole < ApplicationRecord
  belongs_to :admin_role
  belongs_to :admin_user
end
