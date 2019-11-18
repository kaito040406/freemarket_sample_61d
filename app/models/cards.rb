class Cards < ApplicationRecord
  attr_accessor :number, :exp_month, :exp_year, :cvc
  belongs_to :user
  

  validates :user_id,     presence: true
  validates :customer_id, presence: true
  validates :card_id,     presence: true, length: { is: 16}

end
