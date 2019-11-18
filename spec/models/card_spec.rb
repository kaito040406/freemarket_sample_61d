require 'rails_helper'

describe Cards do
  describe '#create' do
  # 1  以下の値にはバリデーションがかかっている
    it "is valid with a user_id, customer_id, card_id" do
      card = build(:cards)
      expect(card).to be_valid
    end
  end
end
