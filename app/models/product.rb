class Product < ApplicationRecord
  has_many :product_images, dependent: :destroy
  belongs_to :user,optional: true
  accepts_nested_attributes_for :product_images, allow_destroy: true #, reject_if: :reject_image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  enum category:                    {"レディース": 1, ##ancestory使用へ置き換えてく
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
  enum size:                       {"xxs以下": 1,
                                    "xs(ss)": 2,
                                    "s": 3,
                                    "M": 4,
                                    "L": 5,
                                    "XL(LL)": 6,
                                    "2XL(3L)": 7,
                                    "3XL(4L)": 8,
                                    "4XL(5L)以上": 9,
                                    "FREE SIZE": 10}
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

  ## enum定義より後にしないとundefined method `categories'エラー
  # validation
  validates :name,                      presence: true, length: { in: 1..40}
  validates :text,                      presence: true, length: { in: 1..1000}
  validates :price,                     numericality: { only_integer: true, greater_than: 299, less_than: 9999999}
  validates :seller_id,                 presence: true, numericality: { only_integer: true}
  validates :category,                   presence: true, inclusion: {in: Product.categories.keys} #presenceDBカラム未設定
  validates :status,                    presence: true
  #validates :brand, brandsテーブルとの連動必要
  #validates :size,                      presence: true categoryに依存、DBには設定あるためコントローラで挿入
  validates :date,                      presence: true
  validates :delivery_fee,              presence: true
  validates :delivery_method,           presence: true #presenceDBカラム未設定
  validates :delivery_from,             presence: true #presenceDBカラム未設定
  validates :estimated_delivery_date,   presence: true #presenceDBカラム未設定
  #validates :buyer_id
  validates :finished,                  presence: true #, DBではdefault: 0

  # def   def reject_image(attributes)
  #   ###empty = attributes[:email].blank?
  #   attributes.merge!(_destroy: 1) if attributes[:_destroy].present?
  #   !exists && empty
  # end
end
