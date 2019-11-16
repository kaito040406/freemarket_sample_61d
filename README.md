# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## addressesテーブル
|integer|user_id|null: false|
|string|prefecture|null: false|
|string|below_city_or_ward|null: false|
|string|below_house_number||
|integer|postal_code|null: false|
|datetime|created_at|null: false|
|datetime|updated_at|null: false|

## brandsテーブル
|integer|user_id|null: false|
|string|prefecture|null: false|
|string|below_city_or_ward|null: false|
|string|below_house_number||
|integer|postal_code|null: false|
|datetime|created_at|null: false|
|datetime|updated_at|null: false|

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|email|string||default: |null: false||
|encrypted_password|string||default: |null: false||
|reset_password_token|string|||
|reset_password_sent_at|datetime||
|remember_created_at|datetime|
|created_at|datetime|null: false||
|updated_at|datetime|null: false||
|nick_name|string||null: false||
|sur_name|string||null: false||
|fr_name|string||null: false||
|sur_name_yomi|string||null: false||
|first_name_yomi|string||null: false||
|introduction|string|||
|birthday_year|integer||
|birthday_manth|integer||
|birthday_day|integer||
|tel_number|string||null: false||
|certification|string||null: false||
|account|integer||
|sales_money|integer||
|point|integer||
|icon_image|string|||
|address_number|string||null: false||
|address_ken|string||null: false||
|address_city|string||null: false||
|address_banch|string||null: false||
|building_name|string|||
|evaluation|integer|default: 0|
|exhibits_number|integer|default: 0|
|provider|string|||

### Association
- has_many :products
- has_many :produst_images
- has_many :cards


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|seller_id|integer|null: false||
|name|string|null: false||
|text|text|null: false||
|price|integer|null: false||
|category|string||
|status|integer|null: false||
|brand|integer||
|size|integer|null: false||
|date|date|null: false||
|delivery_fee|integer|null: false||
|delivery_method|integer||
|delivery_from|integer||
|estimated_delivery_date|integer||
|condition|integer||
|buyer_id|integer||
|finished|integer|default: 0, null: false||
|parent|string||
|child|string||
|grand|string||
|grand_id|integer||
|created_at|datetime|null: false||
|updated_at|datetime|null: false||

### Association
- has_many :product_images
- belongs_to :user

## credit_cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|, foreign_key: true|
|number|integer|null: false||
|expiration_date|date|null: false||

### Association
- belongs_to :user


## addressesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|, foreign_key: true|
|prefecture|string||null: false||
|below_city_or_ward|string||null: false||
|below_house_number|string||null: true|
|postal_code|integer|null: false||

### Association
- belongs_to :user


## product_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false|, foreign_key: true|
|count|integer|null: false||

### Association
- belongs_to :product


## user_bookmarks_productsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|, foreign_key: true|
|product_id|integer|null: false|, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product


## user_product_commentsテーブル

|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false|, foreign_key: true|
|user_id|integer|null: false|, foreign_key: true|
|text|text|null: false||

### Association
- belongs_to :user
- belongs_to :product


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||null: false||
|parent_id|integer|null: true, foreign_key: false||

### Association
- has_many :products


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||null: false||

### Association
- has_many :products
