test
# README

# アプリケーション概要

フリーマーケットアプリ「メルカリ」のクローンアプリケーション

# アプリケーションの機能一覧

Basic認証機能
ユーザー新規登録機能
新規登録時ロボット判定機能
ユーザーログイン／ログアウト機能
ユーザー情報編集機能
マイページ表示機能
出品中／売却済商品表示機能
プロフィール表示
クレジットカード登録／削除機能
商品出品／編集／削除機能
商品購入機能
カテゴリ別商品表示機能
パンくず表示機能

# アプリケーション内で使用している技術一覧

|種別|名称|
|----|---|
|開発言語|Ruby(ver 2.5.1)|
|フレームワーク|Ruby on Rails(ver 5.2.1)|
|マークアップ|HTML(Haml),CSS(Sass)|
|フロントエンド|JavaScript(jQuery)|
|DB|MySQL|
|本番環境|AWS EC2|
|画像アップロード|carrierwave, AWS S3|
|自動デプロイ|capistrano|
|ロボット判定機能|reCAPTCHA|
|ユーザー管理|devise|
|クレジットカード管理|PayJP|
|パンくず表示機能|gretel|


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|prefecture|string|null: false|
|below_city_or_ward|string|null: false|
|below_house_number|string||
|postal_code|integer|null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|prefecture|string|null: false|
|below_city_or_ward|string|null: false|
|below_house_number|string||
|postal_code|integer|null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||null: false|
|parent_id|integer|null: true|foreign_key: false|

### Association
- has_many :products


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|customer_id|string|null: false|
|card_id|string|null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- belongs_to :user


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|
|ancestry|string||
|index ["ancestry"]|name|index_categories_on_ancestry||

### Association
- has_many :products


## merkersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
|genre|string||
|genre_number|integer||
|created_at|datetime|null: false|
|updated_at|datetime|null: false|


## product_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false|
|count|integer||
|created_at|datetime|null: false|
|updated_at|datetime|null: false|
|product_image|string||

### Association
- belongs_to :product


## productsテーブル
|Column|Type|Options|
|------|----|-------|
|seller_id|integer|null: false|
|name|string|null: false|
|text|text|null: false|
|price|integer|null: false|
|category|string||
|status|integer|null: false|
|brand|integer||
|size|integer|null: false|
|date|date|null: false|
|delivery_fee|integer|null: false|
|delivery_method|integer||
|delivery_from|integer||
|estimated_delivery_date|integer||
|condition|integer||
|buyer_id|integer||
|finished|integer|default: 0|null: false|
|parent|string||
|child|string||
|grand|string||
|grand_id|integer||
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- has_many :product_images
- belongs_to :user


## snscredentialsテーブル
|Column|Type|Options|
|------|----|-------|
|providerstring|||
|uid|text||
|mid|integer||
|token|text||
|pass_token|text||
|email|text||
|created_at|datetime|null: false|
|updated_at|datetime|null: false|


## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string||default: |null: false|
|encrypted_password|string||default: |null: false|
|reset_password_token|string|
|reset_password_sent_at|datetime||
|remember_created_at|datetime|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|
|nick_name|string||null: false|
|sur_name|string||null: false|
|fr_name|string||null: false|
|sur_name_yomi|string||null: false|
|first_name_yomi|string||null: false|
|introduction|string|
|birthday_year|integer||
|birthday_manth|integer||
|birthday_day|integer||
|tel_number|string||null: false|
|certification|string||null: false|
|account|integer||
|sales_money|integer||
|point|integer||
|icon_image|string|
|address_number|string||null: false|
|address_ken|string||null: false|
|address_city|string||null: false|
|address_banch|string||null: false|
|building_name|string|
|evaluation|integer|default: 0|
|exhibits_number|integer|default: 0|
|provider|string|

### Association
- has_many :products
- has_many :produst_images
- has_many :cards


## user_bookmarks_productsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false
|product_id|integer|null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|


## user_product_commentsテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false|
|user_id|integer|null: false|
|text|text|null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|
