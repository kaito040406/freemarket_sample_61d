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
    # 4 card_idが16文字以上の場合登録できない
    it "is invalid with a name that has more than 16 characters" do
      card = build(:cards, card_id: 11111111111111111)
      card.valid?
      expect(card.errors[:card_id]).to include("は16文字で入力してください")
    end
    # 5 card_idが16文字以下の場合登録できない
    it "is invalid with a name that has less than 16 characters" do
      card = build(:cards, card_id: 111111111111111)
      card.valid?
      expect(card.errors[:card_id]).to include("は16文字で入力してください")
    end
  end
end
