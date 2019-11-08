class CreditCardsController < ApplicationController
  require "date"
  require "payjp"


  def index
    card = current_user.credit_card
    redirect_to action: "show" unless card.blank?
  end

  def new
    card = current_user.credit_card
    redirect_to action: "show" unless card.blank?

    now_day = Date.today
    now_year = now_day.year % 100
    @year_array = []
    11.times do
      @year_array << now_year
      now_year += 1
    end
  end


  def show
  end

  def pay
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      email: current_user.email, #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end


end
