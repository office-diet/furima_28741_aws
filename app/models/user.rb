class User < ApplicationRecord
  has_many :items
  has_many :purchases

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  JAPANESE_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze
  KATAKANA_REGEX = /\A[ァ-ヶー－]/.freeze

  with_options presence: true do
    validates :nickname, uniqueness: { case_sensitive: true, message: 'has already been taken' }
    validates :email, uniqueness: { case_sensitive: true, message: 'has already been taken' }
    validates :password, format: { with: PASSWORD_REGEX, message: 'input half-width numbers and characters.' }
    validates :family_name, format: { with: JAPANESE_REGEX, message: 'input full-width japanese characters.' }
    validates :first_name, format: { with: JAPANESE_REGEX, message: 'input full-width japanese characters.' }
    validates :family_name_kana, format: { with: KATAKANA_REGEX, message: 'input full-width katakana characters.' }
    validates :first_name_kana, format: { with: KATAKANA_REGEX, message: 'input full-width katakana characters.' }
    validates :birthday
    validates :birthday_valid?
  end

  private

  def birthday_valid?
    date = birthday.to_s
    if date != '' && date.count('-') > 2
      errors.add(:birthday, 'invalid')
    else
      true
    end
  end
end
