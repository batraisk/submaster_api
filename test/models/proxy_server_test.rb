# == Schema Information
#
# Table name: proxy_servers
#
#  id         :bigint           not null, primary key
#  ip         :string
#  port       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ProxyServerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
