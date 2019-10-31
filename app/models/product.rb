class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  #DBのカラム名"categry", # %option{value: ""} \---    <-プレースホルダ
  enum categry:  {"レディース": 1,
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
end