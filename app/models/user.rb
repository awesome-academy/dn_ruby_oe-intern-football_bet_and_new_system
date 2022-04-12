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

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
