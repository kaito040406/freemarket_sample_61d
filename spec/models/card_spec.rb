require 'rails_helper'

describe Cards do
  describe '#create' do
  # 1  以下の値にはバリデーションがかかっている
    it "is valid with a customer_id, card_id" do
      card = build(:cards)
      expect(card).to be_valid
    end

  # 2 customer_idが空の場合登録できない
    it "is invalid without a customer_id" do
      card = build(:cards, customer_id: nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end
  # 3 card_idが空の場合登録できない
  it "is invalid without a card_id" do
    card = build(:cards, card_id: nil)
    card.valid?
    expect(card.errors[:card_id]).to include("を入力してください")
  end
  end
end
