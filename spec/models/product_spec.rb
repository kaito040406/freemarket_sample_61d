require 'rails_helper'

describe Product do
  describe '#create' do
    #1 以下にはバリデーションがかかっている
    it "is valid with a seller_id, name, text, price, category, status, date, delivery_fee, delivery_method, delivery_from, estimated_delivery_date, finished, parent, child, grand, grand_id" do
      product = build(:product)
      expect(product).to be_valid
    end

    #2 seller_idが空の場合登録ができない
    it "is invalid without a seller_id" do
      product = build(:product, seller_id: nil)
      product.valid?
      expect(product.errors[:seller_id]).to include("を入力してください", "は数値で入力してください")
    end

    #3 nameが空の場合登録ができない
    it "is invalid without a name" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("を入力してください", "は1文字以上で入力してください")
    end

    #4 priceが空の場合登録ができない
    it "is invalid without a price" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("を入力してください","は数値で入力してください")
    end

    #5 categoryが空の場合登録ができない
    it "is invalid without a price" do
      product = build(:product, category: nil)
      product.valid?
      expect(product.errors[:category]).to include("を入力してください", "は一覧にありません")
    end

    #6 statusが空の場合登録ができない
    it "is invalid without a status" do
      product = build(:product, status: nil)
      product.valid?
      expect(product.errors[:status]).to include("を入力してください")
    end

    #7 dateが空の場合登録ができない
    it "is invalid without a date" do
      product = build(:product, date: nil)
      product.valid?
      expect(product.errors[:date]).to include("を入力してください")
    end

    #8 delivery_feeが空の場合登録ができない
    it "is invalid without a delivery_fee" do
      product = build(:product, delivery_fee: nil)
      product.valid?
      expect(product.errors[:delivery_fee]).to include("を入力してください")
    end

    #9 delivery_methodが空の場合登録ができない
    it "is invalid without a delivery_method" do
      product = build(:product, delivery_method: nil)
      product.valid?
      expect(product.errors[:delivery_method]).to include("を入力してください")
    end

    #10 delivery_fromが空の場合登録ができない
    it "is invalid without a delivery_from" do
      product = build(:product, delivery_from: nil)
      product.valid?
      expect(product.errors[:delivery_from]).to include("を入力してください")
    end

    #11 estimated_delivery_dateが空の場合登録できない
    it "is invalid without a estimated_delivery_date" do
      product = build(:product, estimated_delivery_date: nil)
      product.valid?
      expect(product.errors[:estimated_delivery_date]).to include("を入力してください")
    end

    #12 finishedが空の場合登録ができない
    it "is invalid without a finished" do
      product = build(:product, finished: nil)
      product.valid?
      expect(product.errors[:finished]).to include("を入力してください")
    end

    #13 parentが空の場合登録ができない
    it "is invalid without a parent" do
      product = build(:product, parent: nil)
      product.valid?
      expect(product.errors[:parent]).to include("を入力してください")
    end

    #14 childが空の場合登録ができない
    it "is invalid without a child" do
      product = build(:product, child: nil)
      product.valid?
      expect(product.errors[:child]).to include("を入力してください")
    end

    #15 grandが空の場合登録ができない
    it "is invalid without a grand" do
      product = build(:product, grand: nil)
      product.valid?
      expect(product.errors[:grand]).to include("を入力してください")
    end

    #16 grandが空の場合登録ができない
    it "is invalid without a grand_id" do
      product = build(:product, grand_id: nil)
      product.valid?
      expect(product.errors[:grand_id]).to include("を入力してください")
    end

    #17 nameが1文字未満だと登録できない
    it "is invalid with a name that has less than 1 characters " do
      product = build(:product, name: "")
      product.valid?
      expect(product.errors[:name]).to include("は1文字以上で入力してください")
    end

    #18 nameが41文字以上だと登録できない
    it "is invalid with a name that has more than 40 characters " do
      product = build(:product, name: "abcdefghijabcdefghijabcdefghijabcdefghija")
      product.valid?
      expect(product.errors[:name]).to include("は40文字以内で入力してください")
    end

    # #19 passwordが7文字以上で登録できること
    # it "is valid for passwords longer than 7 characters " do
    #   product = build(:product, password: "aaaaaaaa", password_confirmation: "aaaaaaaa")
    #   expect(product).to be_valid
    # end

    # #20 sur_name_yomiが漢字では登録ができないこと
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

    # #23郵便番号が形式外だと登録できない
    # it "is valid if out of format" do
    #   product = build(:product, address_number: "5330022")
    #   product.valid?
    #   expect(product.errors[:address_number]).to include("is invalid")
    # end


  end
end