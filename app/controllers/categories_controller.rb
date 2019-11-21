class CategoriesController < ApplicationController
  before_action :set_category ,except: :index
  before_action :set_search

  def index
    @category_parent = Category.where(ancestry: nil)
  end
  
  def show
    @images = ProductImage.where(params[:id])
    @product = Product
  end

  private

  def set_category
    @category = Category.find(params[:id])
    women = Product.where(parent: "レディース")
    men = Product.where(parent: "メンズ")
    kids = Product.where(parent: "ベビー・キッズ")
    items = Product.where(parent: "インテリア・住まい・小物")
    books = Product.where(parent: "本・音楽・ゲーム")
    hobby = Product.where(parent: "おもちゃ・ホビー・グッズ")
    cosme = Product.where(parent: "コスメ・香水・美容")
    home = Product.where(parent: "家電・スマホ・カメラ")
    sports = Product.where(parent: "スポーツ・レジャー")
    hands = Product.where(parent: "ハンドメイド")
    tickets = Product.where(parent: "チケット")
    bikes = Product.where(parent: "自動車・オートバイ")
    others = Product.where(parent: "その他")
  end

  def set_search
    @search = Product.ransack(name: params[:name_cont])
  end
end