# == Schema Information
#
# Table name: promocodes
#
#  id         :bigint           not null, primary key
#  amount     :integer
#  begins_at  :datetime
#  code       :string
#  duration   :integer
#  ends_at    :datetime
#  kind       :string           default("currency"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class PromocodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
