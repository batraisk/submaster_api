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
class ProxyServer < ApplicationRecord
end
