class SignupController < ApplicationController

  def create
    
    @user = User.new(
      nick_name: session[:nick_name],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      sur_name: session[:sur_name],
      fr_name: session[:fr_name],
      sur_name_yomi: session[:sur_name_yomi],
      first_name_yomi: session[:first_name_yomi],
      birthday_year: session[:birthday_year],
      birthday_manth: session[:birthday_manth],
      birthday_day: session[:birthday_day],
      tel_number: session[:tel_number],
      certification: session[:certification],
      address_number: session[:address_number],
      address_ken: session[:address_ken],
      address_city: session[:address_city],
      address_banch: session[:address_banch],
      building_name: session[:building_name],
      icon_image: session[:icon_image]
    )
    if @user.save!
      session[:id] = @user.id
      if session[:sorce] == "sns"
        Snscredential.create(
          provider: session[:provider],
          uid: session[:uid],
          email: session[:email],
          mid: session[:id],
          token: session[:token]
        )
      end
      redirect_to done_signup_index_path
    end
  end

  def sign_in_select
    
  end

  def step1
    @user_data = 'from_mail'
    @user = User.new
  end
  def step2
    session[:nick_name] = user_params[:nick_name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:sur_name] = user_params[:sur_name]
    session[:fr_name] = user_params[:fr_name]
    session[:sur_name_yomi] = user_params[:sur_name_yomi]
    session[:first_name_yomi] = user_params[:first_name_yomi]
    session[:birthday_year] = user_params[:birthday_year]
    session[:birthday_manth] = user_params[:birthday_manth]
    session[:birthday_day] = user_params[:birthday_day]
    if params[:user][:account_source] != nil
      session[:nick_name] = user_params[:nick_name]
      session[:icon_image] = user_params[:icon_image]
      session[:provider] = user_params[:provider]
      session[:uid] = user_params[:uid]
      session[:token] = user_params[:token]
    end
    session[:sorce] = params[:user][:account_source]
    @user = User.new
  end
  def step3
    @user = User.new
    session[:tel_number] = user_params[:tel_number]
  end
  def step4
    session[:certification] = user_params[:certification]
    @user = User.new
    @sur = session[:sur_name]
    @sur_yomi = session[:sur_name_yomi]
    @fr = session[:fr_name]
    @fr_yomi = session[:first_name_yomi]
  end

  def step5
    session[:sur_name] = user_params[:sur_name]
    session[:fr_name] = user_params[:fr_name]
    session[:sur_name_yomi] = user_params[:sur_name_yomi]
    session[:first_name_yomi] = user_params[:first_name_yomi]
    session[:address_number] = user_params[:address_number]
    session[:address_ken] = user_params[:address_ken]
    session[:address_city] = user_params[:address_city]
    session[:address_banch] = user_params[:address_banch]
    session[:building_name] = user_params[:building_name]
    @user = User.new
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  private
  def user_params
    params.require(:user).permit(
      :nick_name,
      :email,
      :password,
      :password_confirmation,
      :sur_name,
      :fr_name,
      :sur_name_yomi,
      :first_name_yomi,
      :birthday_year,
      :birthday_manth,
      :birthday_day,
      :tel_number,
      :certification,
      :address_number,
      :address_ken,
      :address_city,
      :address_banch,
      :building_name,
      :icon_image,
      :uid,
      :mid,
      :provider,
      :token
    )
  end
end