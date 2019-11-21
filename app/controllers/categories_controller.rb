class CategoriesController < ApplicationController
  before_action :set_category ,except: :index
  before_action :check_category, except: :index
  before_action :set_search

  def index
    @category_parent = Category.where(ancestry: nil)
  end
  
  def show
  @products
  @images = ProductImage.where(params[:id])
  end

  private

  def set_category
    @category = Category.find(params[:id])
    @women = Product.where(parent: "レディース")
    @men = Product.where(parent: "メンズ")
    @kids = Product.where(parent: "ベビー・キッズ")
    @items = Product.where(parent: "インテリア・住まい・小物")
    @boocks = Product.where(parent: "本・音楽・ゲーム")
    @hobby = Product.where(parent: "おもちゃ・ホビー・グッズ")
    @cosme = Product.where(parent: "コスメ・香水・美容")
    @home = Product.where(parent: "家電・スマホ・カメラ")
    @sports = Product.where(parent: "スポーツ・レジャー")
    @hands = Product.where(parent: "ハンドメイド")
    @tickets = Product.where(parent: "チケット")
    @bikes = Product.where(parent: "自動車・オートバイ")
    @others = Product.where(parent: "その他")
  end

  def check_category
    if @category.id == 1
      @products = @women
    elsif @category.id == 200
      @products = @men
    elsif  @category.id == 345
      @products = @kids
    elsif  @category.id == 480
      @products = @items
    elsif  @category.id == 623
      @products = @boocks
    elsif  @category.id == 683
      @products = @hobby
    elsif  @category.id == 796
      @products = @cosme
    elsif  @category.id == 896
      @products = @home
    elsif  @category.id == 982
      @products = @sports
    elsif  @category.id == 1091
      @products = @hands
    elsif  @category.id == 1143
      @products = @tickets
    elsif  @category.id == 1202
      @products = @bikes
    else
      @products = @others
    end
  end

  def set_search
    @search = Product.ransack(name: params[:name_cont])
  end
end