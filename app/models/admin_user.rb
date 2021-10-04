# == Schema Information
#
# Table name: admin_users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admin_users_on_email                 (email) UNIQUE
#  index_admin_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  has_many :admin_user_admin_roles
  has_many :admin_roles, through: :admin_user_admin_roles
  accepts_nested_attributes_for :admin_roles, allow_destroy: true

  def available_actions(class_name)
    AdminManagedResource.all
                    .includes(:admin_roles)
                    .where(admin_roles: {id: self.admin_roles})
                    .where(class_name: class_name).map{|a| a[:action]}
    # actions += [:index, :show] if permissions.include?('read')
    # actions += [:destroy] if permissions.include?('destroy')
    # actions += [:new, :update, :create] if permissions.include?('update')
    # actions
  end
  # def available_actions(class_name)
  #   actions = []
  #   permissions = AdminManagedResource.all
  #                   .includes(:admin_roles)
  #                   .where(admin_roles: {id: self.admin_roles})
  #                   .where(class_name: class_name).map{|a| a[:action]}
  #   actions += [:index, :show] if permissions.include?('read')
  #   actions += [:destroy] if permissions.include?('destroy')
  #   actions += [:new, :update, :create] if permissions.include?('update')
  #   actions
  # end

end
