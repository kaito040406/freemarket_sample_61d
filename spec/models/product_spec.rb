require 'rails_helper'

describe Product do
  describe '#create' do
    # 以下にはバリデーションがかかっている
    it "is valid with a seller_id, name, text, price, category, status, date, delivery_fee, delivery_method, delivery_from, estimated_delivery_date, finished, parent, child, grand, grand_id" do
      product = build(:product)
      expect(product).to be_valid
    end

    # seller_idが空の場合登録ができない
    it "is invalid without a seller_id" do
      product = build(:product, seller_id: nil)
      product.valid?
      expect(product.errors[:seller_id]).to include("を入力してください")
    end

    # nameが空の場合登録ができない
    it "is invalid without a name" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    # textが空の場合登録できない
    it "is invalid without a text" do
      product = build(:product, text: nil)
      product.valid?
      expect(product.errors[:text]).to include("を入力してください")
    end

    # priceが空の場合登録ができない
    it "is invalid without a price" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end

    # categoryが空の場合登録ができない
    it "is invalid without a price" do
      product = build(:product, category: nil)
      product.valid?
      expect(product.errors[:category]).to include("を入力してください")
    end

    # statusが空の場合登録ができない
    it "is invalid without a status" do
      product = build(:product, status: nil)
      product.valid?
      expect(product.errors[:status]).to include("を入力してください")
    end

    # dateが空の場合登録ができない
    it "is invalid without a date" do
      product = build(:product, date: nil)
      product.valid?
      expect(product.errors[:date]).to include("を入力してください")
    end

    # delivery_feeが空の場合登録ができない
    it "is invalid without a delivery_fee" do
      product = build(:product, delivery_fee: nil)
      product.valid?
      expect(product.errors[:delivery_fee]).to include("を入力してください")
    end

    # delivery_methodが空の場合登録ができない
    it "is invalid without a delivery_method" do
      product = build(:product, delivery_method: nil)
      product.valid?
      expect(product.errors[:delivery_method]).to include("を入力してください")
    end

    # delivery_fromが空の場合登録ができない
    it "is invalid without a delivery_from" do
      product = build(:product, delivery_from: nil)
      product.valid?
      expect(product.errors[:delivery_from]).to include("を入力してください")
    end

    # estimated_delivery_dateが空の場合登録できない
    it "is invalid without a estimated_delivery_date" do
      product = build(:product, estimated_delivery_date: nil)
      product.valid?
      expect(product.errors[:estimated_delivery_date]).to include("を入力してください")
    end

    # finishedが空の場合登録ができない
    it "is invalid without a finished" do
      product = build(:product, finished: nil)
      product.valid?
      expect(product.errors[:finished]).to include("を入力してください")
    end

    # parentが空の場合登録ができない
    it "is invalid without a parent" do
      product = build(:product, parent: nil)
      product.valid?
      expect(product.errors[:parent]).to include("を入力してください")
    end

    # childが空の場合登録ができない
    it "is invalid without a child" do
      product = build(:product, child: nil)
      product.valid?
      expect(product.errors[:child]).to include("を入力してください")
    end

    # grandが空の場合登録ができない
    it "is invalid without a grand" do
      product = build(:product, grand: nil)
      product.valid?
      expect(product.errors[:grand]).to include("を入力してください")
    end

    # grandが空の場合登録ができない
    it "is invalid without a grand_id" do
      product = build(:product, grand_id: nil)
      product.valid?
      expect(product.errors[:grand_id]).to include("を入力してください")
    end

    # nameが1文字未満だと登録できない
    it "is invalid with a name that has less than 1 characters " do
      product = build(:product, name: "")
      product.valid?
      expect(product.errors[:name]).to include("は1文字以上で入力してください")
    end

    # nameが41文字以上の場合登録できない
    it "is invalid with a name that has more than 40 characters " do
      product = build(:product, name: "abcdefghijabcdefghijabcdefghijabcdefghija")
      product.valid?
      expect(product.errors[:name]).to include("は40文字以内で入力してください")
    end

    # textが1文字未満の場合登録できない
    it "is invalid with a text that has less than 1 characters " do
      product = build(:product, text: "")
      product.valid?
      expect(product.errors[:text]).to include("は1文字以上で入力してください")
    end

    # textが1000文字以上の場合登録できない
    it "is invalid with a text that has more than 1000 characters " do
      product = build(:product, text: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      product.valid?
      expect(product.errors[:text]).to include("は1000文字以内で入力してください")
    end
    
    # priceが文字の場合登録できない
    it "is invalid without a price for charactor" do
      product = build(:product, price: "aaa")
      product.valid?
      expect(product.errors[:price]).to include("は数値で入力してください")
    end

    # priceが10000000円以上の場合登録できない
    it "is invalid without a price that has more than 9999999 price " do
      product = build(:product, price: "10000000")
      product.valid?
      expect(product.errors[:price]).to include("は9999999より小さい値にしてください")
    end

    # priceが299円未満の場合登録できない
    it "is invalid without a price that has less than 299 price " do
      product = build(:product, price: "298")
      product.valid?
      expect(product.errors[:price]).to include("は299より大きい値にしてください")
    end

    # seller_idが文字の場合登録できない
    it "is invalid without a seller_id for charactor" do
      product = build(:product, seller_id: "aaa")
      product.valid?
      expect(product.errors[:seller_id]).to include("は数値で入力してください")
    end

    # categoryがproductの一覧にないものの場合登録できない
    it "is invalid without a category includes product " do
      product = build(:product, category: "")
      product.valid?
      expect(product.errors[:category]).to include("は一覧にありません")
    end

    # finishedが文字の場合登録できない
    it "is invalid without a finished for charactor" do
      product = build(:product,finished: "aaa")
      product.valid?
      expect(product.errors[:finished]).to include("は数値で入力してください")
    end


  end
end