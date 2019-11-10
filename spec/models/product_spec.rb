require 'rails_helper'

describe Product do
  describe '#create' do
    #1 seller_id, name, text, price, categry,status, size, date, delivery_fee, delivery_method, delivery_from, estimated_delivery_date, finishedにはバリデーションがかかっている
    it "is valid with a seller_id, name, text, price, categry,status, size, date, delivery_fee, delivery_method, delivery_from, estimated_delivery_date, finished" do
      product = build(:product)
      expect(product).to be_valid
    end
    #2 seller_idが空だと登録ができない
    it "is invalid without a name" do
      product = build(:product, seller_id: nil)
      product.valid?
      expect(product.errors[:seller_id]).to include("can't be blank")
    end
    #2 nameが空だと登録ができない
    it "is invalid without a name" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end
    #3 textが空だと登録ができない
    it "is invalid without a text" do
      product = build(:product, text: nil)
      product.valid?
      expect(product.errors[:text]).to include("can't be blank")
    end
    #4 priceが空だと登録ができない
    it "is invalid without a price" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("is not a number")
    end

    # #5 passwordが存在してもpassword_confirmationが空では登録できないこと
    # it "is invalid without a password_confirmation although with a password" do
    #   product = build(:product, password_confirmation: "")
    #   product.valid?
    #   expect(product.errors[:password_confirmation]).to include("doesn't match Password")
    # end

    # #6 passwordが6文字以下だと登録できないこと
    # it "is invalid with a password that has less than 6 characters " do
    #   product = build(:product, password: "aaaaa", password_confirmation: "aaaaa")
    #   product.valid?
    #   expect(product.errors[:password]).to include("is too short (minimum is 7 characters)")
    # end

    # #7 passwordが7文字以上で登録できること
    # it "is valid for passwords longer than 7 characters " do
    #   product = build(:product, password: "aaaaaaaa", password_confirmation: "aaaaaaaa")
    #   expect(product).to be_valid
    # end

    # #8 sur_nameが空では登録ができないこと
    # it "is invalid without a sur_name" do
    #   product = build(:product, sur_name: nil)
    #   product.valid?
    #   expect(product.errors[:sur_name]).to include("can't be blank")
    # end

    # #9 fr_nameが空では登録ができないこと
    # it "is invalid without a fr_name" do
    #   product = build(:product, fr_name: nil)
    #   product.valid?
    #   expect(product.errors[:fr_name]).to include("can't be blank")
    # end

    # #9 sur_name_yomiが空では登録ができないこと
    # it "is invalid without a sur_name yomi" do
    #   product = build(:product, sur_name_yomi: nil)
    #   product.valid?
    #   expect(product.errors[:sur_name_yomi]).to include("can't be blank")
    # end

    # #10 sur_name_yomiが漢字では登録ができないこと
    # it "is invalid sur_name_yomi for kanji" do
    #   product = build(:product, sur_name_yomi: "長谷川")
    #   product.valid?
    #   expect(product.errors[:sur_name_yomi][0]).to include("is invalid")
    # end

    # #11 sur_name_yomiがひらがなでは登録ができること
    # it "is registration in Hiragana is valid" do
    #   product = build(:product, sur_name_yomi: "はせがわ")
    #   expect(product).to be_valid
    # end

    # #12 first_name_yomiが空では登録ができないこと
    # it "is invalid without a first_name" do
    #   product = build(:product, first_name_yomi: nil)
    #   product.valid?
    #   expect(product.errors[:first_name_yomi]).to include("can't be blank")
    # end
    
    # #13 first_name_yomiが漢字では登録ができないこと
    # it "is invalid sur_name for kanji" do
    #   product = build(:product, first_name_yomi: "海斗")
    #   product.valid?
    #   expect(product.errors[:first_name_yomi]).to include("is invalid")
    # end

    # #14 first_name_yomiがひらがなで登録ができること
    # it "is registration in Hiragana is valid" do
    #   product = build(:product, first_name_yomi: "かいと")
    #   expect(product).to be_valid
    # end

    # #15 電話番号が11文字以外だと登録できないこと
    # it "is invalid for phone number other than 11 digits" do
    #   product = build(:product, tel_number: "000")
    #   product.valid?
    #   expect(product.errors[:tel_number]).to include("is the wrong length (should be 11 characters)")
    # end

    # #16 電話番号が11文字だと登録できること
    # it "is 11 digit phone number is valid " do
    #   product = build(:product, tel_number: "00000000000")
    #   expect(product).to be_valid
    # end

    # #17 電話番号が文字だと登録できないこと
    # it "is invalid tel_number for charactor " do
    #   product = build(:product, tel_number: "aaaaaaaaaaa")
    #   product.valid?
    #   expect(product.errors[:tel_number]).to include("is not a number")
    # end

    # #18 認証番号が空だと登録できること    
    # it "is invalid without a certification" do
    #   product = build(:product, certification: nil)
    #   product.valid?
    #   expect(product.errors[:certification]).to include("can't be blank")
    # end

    # #19 認証番号が4桁だと登録できること
    # it "is 4 digit certification is valid" do
    #   product = build(:product, certification: "1111")
    #   expect(product).to be_valid
    # end

    # #20 認証番号が4桁以外だと登録できないこと
    # it "is invalid for certification other than 4 digits" do
    #   product = build(:product, certification: "11111")
    #   product.valid?
    #   expect(product.errors[:certification]).to include("is the wrong length (should be 4 characters)")
    # end

    # #21 認証番号が文字だと登録できないこと
    # it "is invalid certification for charactor " do
    #   product = build(:product, certification: "aaaa")
    #   product.valid?
    #   expect(product.errors[:certification]).to include("is not a number")
    # end

    # #22郵便番号が空だと登録できない
    # it "is invalid without a address_number" do
    #   product = build(:product, address_number: nil)
    #   product.valid?
    #   expect(product.errors[:address_number]).to include("can't be blank")
    # end

    # #23郵便番号が形式外だと登録できない
    # it "is valid if out of format" do
    #   product = build(:product, address_number: "5330022")
    #   product.valid?
    #   expect(product.errors[:address_number]).to include("is invalid")
    # end

    # #24県名が空だと登録できない
    # it "is invalid without a address_ken" do
    #   product = build(:product, address_ken: nil)
    #   product.valid?
    #   expect(product.errors[:address_ken]).to include("can't be blank")
    # end

    # #25市町村が空だと登録できない
    # it "is invalid without a address_city" do
    #   product = build(:product, address_city: nil)
    #   product.valid?
    #   expect(product.errors[:address_city]).to include("can't be blank")
    # end

    # #26番地が空だと登録できない
    # it "is invalid without a address_banch" do
    #   product = build(:product, address_banch: nil)
    #   product.valid?
    #   expect(product.errors[:address_banch]).to include("can't be blank")
    # end

  end
end