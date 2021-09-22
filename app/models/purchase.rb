# == Schema Information
#
# Table name: purchases
#
#  id           :bigint           not null, primary key
#  amount       :integer
#  kind         :string           default("subscribe"), not null
#  product_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  page_id      :bigint
#  product_id   :bigint
#  user_id      :bigint           not null
#
# Indexes
#
#  index_purchases_on_page_id  (page_id)
#  index_purchases_on_product  (product_type,product_id)
#  index_purchases_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Purchase < ApplicationRecord
  belongs_to :product, polymorphic: true
  belongs_to :page, optional: true
end
