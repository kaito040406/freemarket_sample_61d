require 'rails_helper'
RSpec.describe Product, type: :model do
  describe '#show' do 
    if "is invalid without a seller_id"
      seller_id = build(:Product, seller_id: 1)
      expect(seller_id).to be_valid
    end
  end
end        