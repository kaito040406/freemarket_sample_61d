class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,  :validatable

  validates :nick_name, presence: true
  validates :sur_name, presence: true
  validates :fr_name, presence: true
  validates :sur_name_yomi, presence: true
  validates :first_name_yomi, presence: true
  validates :birthday_year, presence: true
  validates :birthday_manth, presence: true
  validates :birthday_day, presence: true 
end