class Product < ApplicationRecord
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

  enum status:                     {"新品、未使用": 1,
                                    "未使用に近い": 2, 
                                    "目立った傷や汚れなし": 3,
                                    "やや傷や汚れあり": 4,
                                    "傷や汚れあり": 5,
                                    "全体的に状態が悪い": 6,}

  enum delivery_fee:               {"着払い(購入者負担)": 1,
                                    "送料込み(出品者負担)": 2}

  enum estimated_delivery_date:    {"1~2日で発送": 1,
                                    "2~3日で発送": 2,
                                    "4~7日で発送": 3}
end