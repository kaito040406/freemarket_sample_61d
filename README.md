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


## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nick_name|string|null: false|
|sur_name|string|null: false|
|first_name|string|null: false|
|sur_name_yomi|string|null: false|
|first_name_yomi|string|null: false|
|introduction|string|null: true|
|birthday|date|null: false|
|email|string|null: false|
|password|string|null: false|
|tel_number|string|null: false|
|account|integer|null:false|
|sales_money|integer|null: false|
|point|integer|null: false|
|icon_image|string|null: true|


### Association
- has_many :products
- has_many :address
- has_many :credit_cards
- has_many :user_prduct_comments
- has_many :user_bookmark_prducts


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|ingeter|null: false, foreign_key: true|
|name|string|null: false|
|text|string|null: true|
|price|ingeter|null: false|
|status|string|null: true|
|category|string|null: false|
|brand|string|null: true|
|size|string|null: false|
|date|date|null: false|
|delivery_fee|string|null: false|
|delivery_method|string|null: false|
|delivery_from|string|null: true|
|estimated_delivery_date|date|null: true|
|user_id(buiyer)|ingeter|null: true, foreign_key: true|
|finished|boolian|null: false|

### Association
- belongs_to :user
- has_many :product_images
- has_many :user_product_comments
- has_many :user_bookmarks_products
- belongs_to :brand
- belongs_to :category


## credit_cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|number|integer|null: false|
|expiration_date|date|null: false|

### Association
- belongs_to :user


## addressesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|prefecture|string|null: false|
|below_city_or_ward|string|null: false|
|below_house_number|string|null: true|
|postal_code|integer|null: false|

### Association
- belongs_to :user


## product_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|count|integer|null: false|

### Association
- belongs_to :product


## user_bookmarks_productsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|product_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product


## user_product_commentsテーブル

|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
|text|text|null: false|

### Association
- belongs_to :user
- belongs_to :product


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|parent_id|integer|null: true, foreign_key: false|

### Association
- has_many :products


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :products
