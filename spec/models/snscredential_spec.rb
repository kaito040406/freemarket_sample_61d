# require 'rails_helper'

# RSpec.describe Snscredential, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

require 'rails_helper'
describe Snscredential do
  describe '#create' do
    #1 バリテーションがかかっている全ての情報があれば登録できること(providerはfacebook)
    it "is valid with a provider, mid, email, uid, token" do
      snscredential = build(:snscredential)
      expect(snscredential).to be_valid
    end

    #2 バリテーションがかかっている全ての情報があれば登録できること(providerはgoogle_oauth2)
    it "is valid with a provider, mid, email, uid, token" do
      snscredential = build(:snscredential, provider: "google_oauth2")
      expect(snscredential).to be_valid
    end

    #3 emailが空だと登録ができない
    it "is invalid without a email" do
      snscredential = build(:snscredential, email: nil)
      snscredential.valid?
      expect(snscredential.errors[:email]).to include("can't be blank")
    end

    #4 uidが空だと登録ができない
    it "is invalid without a uid" do
      snscredential = build(:snscredential, uid: nil)
      snscredential.valid?
      expect(snscredential.errors[:uid]).to include("can't be blank")
    end

    #5 midが空では登録ができないこと
    it "is invalid without a mid" do
      snscredential = build(:snscredential, mid: nil)
      snscredential.valid?
      expect(snscredential.errors[:mid]).to include("can't be blank")
    end

    #6 providerが指定以外のものだと登録できないこと
    it "is invalid without a address_ken" do
      snscredential = build(:snscredential, provider: "twitter")
      snscredential.valid?
      expect(snscredential.errors[:provider]).to include("is not included in the list")
    end

    #7 mail addressが形式以外のものだと登録できないこと
    it "is invalid without a mail" do
      snscredential = build(:snscredential, email: "aaaaa")
      snscredential.valid?
      expect(snscredential.errors[:email]).to include("is invalid")
    end
  end
end