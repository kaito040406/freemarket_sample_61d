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
|nick_name|string|null: true, foreign_key: false|
|icon|string|null: true, foreign_key: false|
|text|string|null: true, foreign_key: false|
|like_number|string|null: false, foreign_key: false|
|name|string|null: false, foreign_key: false|
|address|string|null: false, foreign_key: false|
|tel_number|string|null: false, foreign_key: false|
|email|string|null: false, foreign_key: false|
|password|string|null: false, foreign_key: false|
|credit_card|string|null: true, foreign_key: false|
|sales_money|integer|null: false, foreign_key: false|
|point|integer|null: false, foreign_key: false|

|like_number|string|null: false, foreign_key: false|


### Association
- has_many :products
- has_many :messages


## productsテーブル

|Column|Type|Options|
|------|----|-------|

|id|ingeter|null: false, foreign_key: true| <- ?
|user_id|ingeter|null: false, foreign_key: true|
|product_information|string|null: false, foreign_key: false|
|name|string|null: false, foreign_key: false|
|text|string|null: true, foreign_key: false|
|price|ingeter|null: false, foreign_key: false|
|category|string|null: true, foreign_key: false|
|brand|string|null: true, foreign_key: false|
|status|string|null: true, foreign_key: false|
|date|date|null: false, foreign_key: false|
|image|string|null: true, foreign_key: false|
|product_size|string|null: false, foreign_key: false|
|delivery_fee|string|null: false, foreign_key: false|
|delivery_method|string|null: false, foreign_key: false|
|delivery_from|string|null: true, foreign_key: false|
|estimated_delivery_date|date|null: true, foreign_key: false|


### Association
- belongs_to :users
- has_many :comments


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
|text|string|null: false, foreign_key: false|

### Association
- belongs_to :user
- belongs_to :product