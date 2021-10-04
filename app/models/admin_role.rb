# == Schema Information
#
# Table name: admin_roles
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AdminRole < ApplicationRecord
  has_many :admin_permissions
  has_many :admin_user_admin_roles
  has_many :admin_users, through: :admin_user_admin_roles
  has_many :admin_managed_resources, through: :admin_permissions
  accepts_nested_attributes_for :admin_managed_resources, allow_destroy: true
end
