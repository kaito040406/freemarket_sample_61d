class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,  :validatable, password_length: 7..128

  validates :nick_name, presence: true
  validates :sur_name, presence: true
  validates :fr_name, presence: true
  validates :sur_name_yomi, presence: true, format: { with: /\A[ぁ-んー－]+\z/}
  validates :first_name_yomi, presence: true, format: { with: /\A[ぁ-んー－]+\z/}
  validates :birthday_year, presence: true, numericality: true
  validates :birthday_manth, presence: true, numericality: true
  validates :birthday_day, presence: true, numericality: true
  validates :tel_number, presence: true, length: { is: 11 }, numericality: true
  validates :certification, presence: true, length: { is: 4 }, numericality: true
  validates :address_number, presence: true, format: {with: /\A\d{3}[-]\d{4}\z/}
  validates :address_ken, presence: true
  validates :address_city, presence: true
  validates :address_banch, presence: true
end