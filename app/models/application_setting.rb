# == Schema Information
#
# Table name: application_settings
#
#  id               :bigint           not null, primary key
#  application_host :string
#  privacy_policy   :string
#  singleton_guard  :integer
#  support_link     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_application_settings_on_singleton_guard  (singleton_guard) UNIQUE
#
class ApplicationSetting < ApplicationRecord
  validates_inclusion_of :singleton_guard, :in => [0]
  def self.instance
    # there will be only one row, and its ID must be '1'
    begin
      find(1)
    rescue ActiveRecord::RecordNotFound
      # slight race condition here, but it will only happen once
      row = ApplicationSetting.new
      row.singleton_guard = 0
      row.save!
      row
    end
  end
end
