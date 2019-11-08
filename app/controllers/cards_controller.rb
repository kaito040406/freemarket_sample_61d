class CardsController < ApplicationController
  require "date"
  require "payjp"

  def index
  end

  def new
  

    now_day = Date.today
    now_year = now_day.year % 100
    @year_array = []
    11.times do
      @year_array << now_year
      now_year += 1
    end
  end

  def pay #クレジットカード登録
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjpToken'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjpToken'],
      metadata: {user_id: current_user.id}
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def buy
    unless user_signed_in?
      redirect_to registration_users_path
    else
      card = current_user.credit_card
      if card.blank?
        redirect_to action: "new"
      else
        @product = Product.find(params[:product_id])
        card = current_user.credit_card
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        Payjp::Charge.create(
        amount: @product.price,
        customer: card.customer_id,
        currency: 'jpy',
        )
        if @product.update(status: 1, buyer_id: current_user.id,buyed_time: DateTime.now)
          redirect_to controller: "products", action: 'show'
        else
          redirect_to controller: "products", action: 'show'
        end
      end
    end
  end

  def show
    card = current_user.credit_card
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
  end

  def delete
    card = current_user.credit_card
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
  end
end
