# == Schema Information
#
# Table name: user_accounts
#
#  id              :bigint           not null, primary key
#  password_digest :string
#  role            :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_user_accounts_on_user_id   (user_id)
#  index_user_accounts_on_username  (username) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserAccount < ApplicationRecord
  belongs_to :user

  has_secure_password

  attr_accessor :confirm_password

  validates :username, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 },
    format: {
      with: /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}/,
      message: :weak_password
    }
  validates :confirm_password, presence: true
  enum role: { user: 0, admin: 1, super_admin: 2 }
  validates :role, presence: true, inclusion: { in: roles.keys }

  validate :passwords_match

  before_save :downcase_attributes

  private

  def passwords_match
    return if password == confirm_password

    errors.add(:confirm_password, :password_mismatch)
  end

  def downcase_attributes
    self.username = username.downcase
  end
end
