class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    
    callback_from :facebook
  end
 
  private
 
  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    check = Snscredential.find_by(uid: request.env['omniauth.auth'][:uid])

    if check != nil
      sign_in User.find(check.mid) unless user_signed_in?
      redirect_to root_path
    else
      pass_token = SecureRandom.base64()
      @user = User.new(
        nick_name: request.env['omniauth.auth'][:info][:name],
        email: request.env['omniauth.auth'][:info][:email],
        password: pass_token,
        password_confirmation: pass_token,
        icon_image: request.env['omniauth.auth'][:info][:image],
        sur_name: "",
        fr_name: "",
        sur_name_yomi: "",
        first_name_yomi: "",
        birthday_manth: "",
        birthday_year: "",
        birthday_day: "",
        tel_number: "",
        certification: "",
        address_number: "",
        address_ken: "",
        address_city: "",
        address_banch: "",
        building_name: ""
      )
      #session["devise.#{provider}_data"] = request.env['omniauth.auth']
      @user.save!(validate: false)
      @snscredential = Snscredential.new(
        mid: @user.id,
        uid: request.env['omniauth.auth'][:uid],
        provider: request.env['omniauth.auth'][:provider],
        token: request.env['omniauth.auth'][:credentials],
        pass_token: pass_token
      )
      if @snscredential.save
        sign_in User.find(@user.id) unless user_signed_in?
        redirect_to root_path
      end
    end
  end
end