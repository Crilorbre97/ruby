# == Schema Information
#
# Table name: purchases
#
#  id           :bigint           not null, primary key
#  price        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_id   :bigint           not null
#  purchaser_id :bigint           not null
#
# Indexes
#
#  index_purchases_on_product_id    (product_id)
#  index_purchases_on_purchaser_id  (purchaser_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (purchaser_id => users.id)
#
class Purchase < ApplicationRecord
  belongs_to :product
  belongs_to :purchaser, class_name: "User", default: -> { Current.user }

  validates :product_id, uniqueness: true
end
