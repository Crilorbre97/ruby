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

  validates :label, presence: true, length: { minimum: 3 }
  validates :label, uniqueness: true, if: -> { label.present? && label.length >= 3 }

  before_save :downcase_attrs

  private

  def downcase_attrs
    self.label = label.downcase
  end
end
