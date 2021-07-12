# == Schema Information
#
# Table name: instagram_credentials
#
#  id         :bigint           not null, primary key
#  login      :string           not null
#  password   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class InstagramCredential < ApplicationRecord
end
