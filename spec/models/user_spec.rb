require 'rails_helper'
describe User do
  describe '#create' do
    # バリテーションがかかっている全ての情報があれば登録できること
    it "is valid with a nick_name, email, password, password_confirmation, sur_name, fr_name, sur_name_yomi, first_name_yomi, birthday_year, birthday_manth, birthday_day, tel_number, certification, address_number ,address_ken, address_city, address_banch" do
      user = build(:user)
      expect(user).to be_valid
    end

    # nick_nameが空では登録ができないこと
    it "is invalid without a nick_name" do
      user = build(:user, nick_name: nil)
      user.valid?
      expect(user.errors[:nick_name]).to include("を入力してください")
    end

    # emailが空だと登録ができない
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # passwordが空では登録ができないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    # sur_nameが空では登録ができないこと
    it "is invalid without a sur_name" do
      user = build(:user, sur_name: nil)
      user.valid?
      expect(user.errors[:sur_name]).to include("を入力してください")
    end

    # fr_nameが空では登録ができないこと
    it "is invalid without a fr_name" do
      user = build(:user, fr_name: nil)
      user.valid?
      expect(user.errors[:fr_name]).to include("を入力してください")
    end

    # first_name_yomiが空では登録ができないこと
    it "is invalid without a first_name_yomi" do
      user = build(:user, first_name_yomi: nil)
      user.valid?
      expect(user.errors[:first_name_yomi]).to include("を入力してください")
    end

    # sur_name_yomiが空では登録ができないこと
    it "is invalid without a sur_name yomi" do
      user = build(:user, sur_name_yomi: nil)
      user.valid?
      expect(user.errors[:sur_name_yomi]).to include("を入力してください")
    end

    # birthday_yearが空では登録ができないこと
    it "is invalid without a birthday_year" do
      user = build(:user, birthday_year: nil)
      user.valid?
      expect(user.errors[:birthday_year]).to include("を入力してください")
    end

    # birthday_manthが空では登録ができないこと
    it "is invalid without a birthday_manth" do
      user = build(:user, birthday_manth: nil)
      user.valid?
      expect(user.errors[:birthday_manth]).to include("を入力してください")
    end
    # birthday_dayが空では登録ができないこと
    it "is invalid without a birthday_day" do
      user = build(:user, birthday_day: nil)
      user.valid?
      expect(user.errors[:birthday_day]).to include("を入力してください")
    end
    
    # 電話番号が空では登録できない
    it "is invalid without a tel_number" do
      user = build(:user, tel_number: nil)
      user.valid?
      expect(user.errors[:tel_number]).to include("を入力してください")
    end

    # 認証番号が空だと登録できないこと    
    it "is invalid without a certification" do
      user = build(:user, certification: nil)
      user.valid?
      expect(user.errors[:certification]).to include("を入力してください")
    end

    # 郵便番号が空だと登録できない
    it "is invalid without a address_number" do
      user = build(:user, address_number: nil)
      user.valid?
      expect(user.errors[:address_number]).to include("を入力してください")
    end

    # 県名が空だと登録できない
    it "is invalid without a address_ken" do
      user = build(:user, address_ken: nil)
      user.valid?
      expect(user.errors[:address_ken]).to include("を入力してください")
    end

    # 市町村が空だと登録できない
    it "is invalid without a address_city" do
      user = build(:user, address_city: nil)
      user.valid?
      expect(user.errors[:address_city]).to include("を入力してください")
    end

    # 番地が空だと登録できない
    it "is invalid without a address_banch" do
      user = build(:user, address_banch: nil)
      user.valid?
      expect(user.errors[:address_banch]).to include("を入力してください")
    end

    # passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    # passwordが6文字以下だと登録できないこと
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "aaaaa", password_confirmation: "aaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    # passwordが7文字以上で登録できること
    it "is valid for passwords longer than 7 characters " do
      user = build(:user, password: "aaaaaaaa", password_confirmation: "aaaaaaaa")
      expect(user).to be_valid
    end

    # sur_name_yomiが漢字では登録ができないこと
    it "is invalid sur_name_yomi for kanji" do
      user = build(:user, sur_name_yomi: "長谷川")
      user.valid?
      expect(user.errors[:sur_name_yomi][0]).to include("は不正な値です")
    end

    # sur_name_yomiが平仮名では登録ができないこと
    it "is invalid sur_name_yomi for kanji" do
      user = build(:user, sur_name_yomi: "はせがわ")
      user.valid?
      expect(user.errors[:sur_name_yomi][0]).to include("は不正な値です")
    end

    # sur_name_yomiがカタカナでは登録ができること
    it "is registration in Hiragana is valid" do
      user = build(:user, sur_name_yomi: "ハセガワ")
      expect(user).to be_valid
    end
    
    # first_name_yomiが漢字では登録ができないこと
    it "is invalid sur_name for kanji" do
      user = build(:user, first_name_yomi: "海斗")
      user.valid?
      expect(user.errors[:first_name_yomi]).to include("は不正な値です")
    end

    # first_name_yomiが漢平仮名では登録ができないこと
    it "is invalid sur_name for kanji" do
      user = build(:user, first_name_yomi: "かいと")
      user.valid?
      expect(user.errors[:first_name_yomi]).to include("は不正な値です")
    end

    # first_name_yomiがひらがなで登録ができること
    it "is registration in Hiragana is valid" do
      user = build(:user, first_name_yomi: "カイト")
      expect(user).to be_valid
    end

    # birthday_yearが数字以外では登録ができないこと
    it "is invalid without a birthday_year" do
      user = build(:user, birthday_year: "aaa")
      user.valid?
      expect(user.errors[:birthday_year]).to include("は数値で入力してください")
    end

    # birthday_manthが数字以外登録ができないこと
    it "is invalid without a birthday_manth" do
      user = build(:user, birthday_manth: "aaa")
      user.valid?
      expect(user.errors[:birthday_manth]).to include("は数値で入力してください")
    end

    # birthday_dayが数字以外登録ができないこと
    it "is invalid without a birthday_day" do
      user = build(:user, birthday_day: "aaa")
      user.valid?
      expect(user.errors[:birthday_day]).to include("は数値で入力してください")
    end
    
    # 電話番号が11文字以上だと登録できないこと
    it "is invalid for phone number longer than 11 digits" do
      user = build(:user, tel_number: "000000000000")
      user.valid?
      expect(user.errors[:tel_number]).to include("は11文字以内で入力してください")
    end

    # 電話番号が10文字未満だと登録できないこと
    it "is invalid for phone number more than 10 digits" do
      user = build(:user, tel_number: "000000000")
      user.valid?
      expect(user.errors[:tel_number]).to include("は10文字以上で入力してください")
    end

    # 電話番号が文字だと登録できないこと
    it "is invalid tel_number for charactor " do
      user = build(:user, tel_number: "aaaaaaaaaaa")
      user.valid?
      expect(user.errors[:tel_number]).to include("は数値で入力してください")
    end

    # 電話番号が10文字だと登録できること
    it "is 10 digit phone number is valid " do
      user = build(:user, tel_number: "0000000000")
      expect(user).to be_valid
    end

    # 電話番号が11文字だと登録できること
    it "is 11 digit phone number is valid " do
      user = build(:user, tel_number: "00000000000")
      expect(user).to be_valid
    end

    # 認証番号が4桁だと登録できること
    it "is 4 digit certification is valid" do
      user = build(:user, certification: "1111")
      expect(user).to be_valid
    end

    # 認証番号が4桁以外だと登録できないこと
    it "is invalid for certification other than 4 digits" do
      user = build(:user, certification: "11111")
      user.valid?
      expect(user.errors[:certification]).to include("は4文字で入力してください")
    end

    it "is invalid for certification other than 4 digits" do
      user = build(:user, certification: "111")
      user.valid?
      expect(user.errors[:certification]).to include("は4文字で入力してください")
    end

    # 認証番号が文字だと登録できないこと
    it "is invalid certification for charactor " do
      user = build(:user, certification: "aaaa")
      user.valid?
      expect(user.errors[:certification]).to include("は数値で入力してください")
    end

    #郵便番号が形式外だと登録できない
    it "is valid if out of format" do
      user = build(:user, address_number: "5330022")
      user.valid?
      expect(user.errors[:address_number]).to include("は不正な値です")
    end
  end
end