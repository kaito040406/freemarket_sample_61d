class Snscredential < ApplicationRecord
  validates :provider, presence: true, :inclusion => { :in => %w(facebook google_oauth2) }
  validates :uid, presence: true
  validates :mid, presence: true
  validates :email, presence: true, format: {with: /\A\S+@\S+\.\S+\z/}
end