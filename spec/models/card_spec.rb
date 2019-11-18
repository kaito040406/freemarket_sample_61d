require 'rails_helper'

describe Cards do
  describe '#pay' do
  # 1  以下の値にはバリデーションがかかっている
    it "is valid with a user_id, customer_id, card_id" do
      user
      card = build(:cards)
      binding.pry
      expect(card).to be_valid
    end
  end
end
