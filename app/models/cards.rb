class Cards < ApplicationRecord
  attr_accessor :number, :exp_month, :exp_year, :cvc
  
  
  validates :customer_id, presence: true
  validates :card_id,     presence: true, length: { is: 16}

  belongs_to :user

end