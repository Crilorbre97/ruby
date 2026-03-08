# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  label      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_label  (label) UNIQUE
#
class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_exception

  validates :label, presence: true, uniqueness: true

  before_save :downcase_attrs

  private

  def downcase_attrs
    self.label = label.downcase
  end
end
