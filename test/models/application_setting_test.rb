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
require "test_helper"

class ApplicationSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
