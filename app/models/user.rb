class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,  :validatable,
         :omniauthable
  
  def self.from_omniauth(auth) #userがいなかったらfacebookでuserを作成するメソッド
    user = User.where(email: auth.info.email).first
    if user
      return user
    else
      where(provider: auth.privuder, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.fname = auth.info.fname
        user.fimage = auth.info.fimage
        user.uid = auth.uid
        user.provider = auth.provuder
        user.skip_confirmation!
      end
    end
  end
end