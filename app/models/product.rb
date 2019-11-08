class Product < ApplicationRecord
  has_many :product_images
  belongs_to :user,optional: true
  belongs_to :category
  accepts_nested_attributes_for :product_images
  validates :seller_id, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  enum categry:                    {"レディース": 1,
                                    "メンズ": 2, 
                                    "ベビー・キッズ": 3,
                                    "インテリア・住まい・小物": 4,
                                    "本・音楽・ゲーム": 5,
                                    "おもちゃ・ホビー・グッズ": 1328,
                                    "コスメ・香水・美容": 6,
                                    "家電・スマホ・カメラ": 7,
                                    "スポーツ・レジャー": 8,
                                    "ハンドメイド": 9,
                                    "チケット": 1027,
                                    "自動車・オートバイ": 1318,
                                    "その他": 10}

  enum categry_ladies:             {"トップス": 11,
                                    "ジャケット/アウター": 12, 
                                    "パンツ": 13,
                                    "スカート": 14,
                                    "ワンピース": 15,
                                    "靴": 16,
                                    "ルームウェア/パジャマ": 17,
                                    "レッグウェア": 18,
                                    "帽子": 19,
                                    "バッグ": 20,
                                    "アクセサリー": 21,
                                    "へアアクセサリー": 22,
                                    "小物": 23,
                                    "時計": 24,
                                    "ウィッグ/エクステ": 25,
                                    "浴衣/水着": 26,
                                    "スーツ/フォーマル/ドレス": 27,
                                    "マタニティ": 28,}
                                    # "その他": 29}

  enum status:                     {"新品、未使用": 1,
                                    "未使用に近い": 2, 
                                    "目立った傷や汚れなし": 3,
                                    "やや傷や汚れあり": 4,
                                    "傷や汚れあり": 5,
                                    "全体的に状態が悪い": 6}

  enum delivery_fee:               {"着払い(購入者負担)": 1,
                                    "送料込み(出品者負担)": 2}
  enum delivery_method:            {"未定": 5,
                                    "らくらくメルカリ便": 14,
                                    "ゆうメール": 6,
                                    "レターパック": 8,
                                    "普通郵便(定形、定形外)": 9,
                                    "クロネコヤマト": 10,
                                    "ゆうパック": 11,
                                    "クリックポスト": 13,
                                    "ゆうパケット": 7}

  enum estimated_delivery_date:    {"1~2日で発送": 1,
                                    "2~3日で発送": 2,
                                    "4~7日で発送": 3}
end
