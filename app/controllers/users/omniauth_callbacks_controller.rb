class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from :facebook
  end

  def google_oauth2
    callback_from :google
  end
 
  private
 
  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    check = Snscredential.find_by(token: request.env['omniauth.auth'][:uid])
    if check != nil
      binding.pry
      sign_in User.find(check.mid) unless user_signed_in?
      redirect_to root_path
    else
      @email = request.env['omniauth.auth'][:info][:email]
      mail_check = User.find_by(email: @email)
      if mail_check == nil
        pass_token = SecureRandom.base64()
        @user_data = "from_sns"
        @nick_name = request.env['omniauth.auth'][:info][:name]
        @password = pass_token
        @password_confirmation = pass_token
        @icon_image = request.env['omniauth.auth'][:info][:image]
        @user = User.new
        @provider = request.env['omniauth.auth'][:provider]
        @uid = request.env['omniauth.auth'][:uid]
        @account_source = "sns"
        @token = request.env['omniauth.auth'][:credentials][:token]
        render template: 'signup/step1'
      else
        Snscredential.create(
          provider: request.env['omniauth.auth'][:provider],
          uid: request.env['omniauth.auth'][:uid],
          email: request.env['omniauth.auth'][:info][:email],
          mid: mail_check.id,
          token: request.env['omniauth.auth'][:credentials][:token]
          )
          sign_in User.find(mail_check.id) unless user_signed_in?
          redirect_to root_path
      end
    end
  end
end

