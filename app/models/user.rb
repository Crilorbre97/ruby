# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  avatar_url :string
#  birth_date :date             not null
#  email      :string           not null
#  gender     :integer          not null
#  lastname   :string
#  name       :string           not null
#  phone      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_one :user_account, dependent: :destroy
  has_many :products, dependent: :destroy

  accepts_nested_attributes_for :user_account

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true,
    format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }
  validates :phone, presence: true,
    format: {
      with: /[76]{1}[0-9]{8}/,
      message: :invalid_phone
    }

  enum :gender, { male: 0, female: 1, other: 2 }
  validates :gender, presence: true, inclusion: { in: genders.keys }
  validates :birth_date, presence: true
  validate :is_more_than_18

  before_save :downcase_attributes

  def is_admin?
    user_account&.role == "admin"
  end

  private

  def is_more_than_18
    return unless birth_date.present?
    return if birth_date <= 18.years.ago.to_date

    errors.add(:birth_date, :not_user_allowed)
  end

  def downcase_attributes
    self.email = email.downcase
  end
end
