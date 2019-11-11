class CardsController < ApplicationController
  require "date"
  require "payjp"


  def index
  end

  def new
    card = Card.where(user_id: current_user.id).first
    redirect_to action: "index" if card.present?
  end

  def pay #PayjpとCardのデータベースを作成
    Payjp.api_key = 'sk_test_6ad53d673b706277ccd8b2c4'
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
        flash[:notice] = 'クレジットカードの登録が完了しました'
      else
        redirect_to action: "pay"
        flash[:alert] = 'クレジットカード登録に失敗しました'
      end
    end
  end

  def show
  end

  def pay
  end


end
