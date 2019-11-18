class Cards < ApplicationRecord
  attr_accessor :number, :exp_month, :exp_year, :cvc
  belongs_to :user
end