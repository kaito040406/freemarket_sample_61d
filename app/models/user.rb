class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, 
         :validatable,
         :omniauthable, 
         omniauth_providers: [:facebook, :google_oauth2]
         


  validates :nick_name, presence: true
  validates :sur_name, presence: true
  validates :fr_name, presence: true
  validates :sur_name_yomi, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :first_name_yomi, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :birthday_year, presence: true, numericality: true
  validates :birthday_manth, presence: true, numericality: true
  validates :birthday_day, presence: true, numericality: true
  validates :tel_number, presence: true, length: { is: 11 }, numericality: true
  validates :certification, presence: true, length: { is: 4 }, numericality: true
  validates :address_number, presence: true, format: {with: /\A\d{3}[-]\d{4}\z/}
  validates :address_ken, presence: true
  validates :address_city, presence: true
  validates :address_banch, presence: true

  has_many :products
  has_many :produst_images
  has_many :cards

  def self.find_for_oauth(auth)
    user = User.where(id: auth.id, provider: auth.provider).first

    unless user
      user = User.create(
        id:      auth.id,
        email:    auth.info.email,
        provider: auth.provider,
        nick_name:  auth.info.nick_name,
        password: Devise.friendly_token[0, 20],
        icon_image:  auth.info.icon_image
      )
    end
    user
  end
end