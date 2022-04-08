class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :currencies, dependent: :nullify
  has_many :user_bets, dependent: :destroy
  has_many :bets, through: :user_bets, dependent: :destroy
  has_many :newses, dependent: :nullify
  has_many :comments, dependent: :destroy

  attr_accessor :remember_token
  before_save :downcase_email

  validates :name, presence: true
  validates :email, presence: true,
            length: {maximum: Settings.user.email.max_length},
            format: {with: Settings.user.email.VALID_EMAIL_REGEX.freeze}
  validates :password,
            length: {in: Settings.digits.digit_6..Settings.digits.digit_21},
            allow_nil: true

  private

  def downcase_email
    email.downcase!
  end
end
