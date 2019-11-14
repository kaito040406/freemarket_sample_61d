class ProductsController < ApplicationController

  require 'payjp'


  before_action :authenticate_user!, except: [:index]
  before_action :set_product, only: [:destroy, :show, :my_details, :purchase_confirmation, :buy]

  def index
    @product = Product.where(finished: 0).length
    @products = Product.limit(10).order('created_at DESC')
    @images = ProductImage.limit(10).order("created_at DESC")
  end

  
  def new
    @category_parent = Category.where(ancestry: nil)
    @product = Product.new

    10.times { @product.product_images.build }
  end

  def create

    @product = Product.new(product_params)
    #@product.user = current_user
    if @product.save!(validate: false)

      redirect_to :root
    else
      #render :new
    end
  end

  def destroy
    if @product.seller_id == current_user.id
      if @product.destroy
          redirect_to root_path
        else
          redirect_to show_products_path(product)
        end 
    else
      redirect_to show_products_path(product)
    end
  end

  def edit
    @product = Product.find(params[:id])
  end
  
  def show
    @product = Product.find(params[:id])
    @image = ProductImage.find_by(product_id: params[:id])
    @user = User.find_by(id: @product.seller_id)
  end  

  def buy
  end

  def my_details
    @product = Product.find(params[:id])
    @image = ProductImage.all
    @user = User.all
  end


  def updete
    @product = Product.updete(params[:id])
    @product.product_id.each do |product|
      product.destroy
    end  
  end  

  def my_details
  end

  def purchase_confirmation
    @product = Product.find(params[:id])
    @images = ProductImage.find_by(product_id: params[:id])
  end


  def buy #クレジット購入
    @product = Product.find(params[:id])
    unless user_signed_in?
      redirect_to registration_users_path
      flash[:alert] = '購入には新規登録が必要です'
    else
      card = Cards.find_by(user_id: current_user.id)
      if card.blank?
        redirect_to action: "new"
        flash[:alert] = '購入にはクレジットカード登録が必要です'
      else
        card = Cards.find_by(user_id: current_user.id)
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        Payjp::Charge.create(
        amount: @product.price, #支払金額
        customer: card.customer_id, #顧客ID
        currency: 'jpy', #日本円
        )
        if @product.update_attribute(:finished, 1)
          flash[:notice] = '購入しました。'
          redirect_to controller: "products", action: 'show'
        else
          flash[:alert] = '購入に失敗しました。'
          redirect_to controller: "products", action: 'show'
        end
      end
    end
  end
end
  private

  def set_product
    @product = Product.find(params[:product_id])
  end
  
  def product_image_params
    params.require(:product_image).permit(:product_id, :product_image)
  end

  def product_params
    params[:product][:seller_id] = current_user.id
    # バリデーションエラー回避のため適当なデータ挿入
    params[:product][:size] = 1
    params[:product][:date] = Date.current

    params[:product][:child] = params[:child]
    params[:product][:grand] = params[:grand]
    params[:product][:parent] = params[:product][:categry]


    # if params[:product][:categry] == 1 
    #   params[:product][:parent] = "レディース"
    # elsif params[:product][:categry] == 2 
    #   params[:product][:parent] = "メンズ"
    # elsif params[:product][:categry] == 3 
    #   params[:product][:parent] = "ベビー・キッズ"
    # elsif params[:product][:categry] == 4 
    #   params[:product][:parent] = "インテリア・住まい・小物"
    # elsif params[:product][:categry] == 5 
    #   params[:product][:parent] = "本・音楽・ゲーム"
    # elsif params[:product][:categry] == 1328 
    #   params[:product][:parent] = "本・音楽・ゲーム"
    # elsif params[:product][:categry] == 6 
    #   params[:product][:parent] = "おもちゃ・ホビー・グッズ"
    # elsif params[:product][:categry] == 7 
    #   params[:product][:parent] = "コスメ・香水・美容"
    # elsif params[:product][:categry] == 8 
    #   params[:product][:parent] = "家電・スマホ・カメラ"
    # elsif params[:product][:categry] == 9 
    #   params[:product][:parent] = "スポーツ・レジャー"
    # elsif params[:product][:categry] == 1027 
    #   params[:product][:parent] = "チケット"
    # elsif params[:product][:categry] == 1318 
    #   params[:product][:parent] = "自動車・オートバイ"
    # elsif params[:product][:categry] == 10 
    #   params[:product][:parent] = "その他"
    # end



    params.require(:product).permit(:seller_id, :name, :text, :categry, :status, :size, :date, :delivery_fee, :delivery_method, :delivery_from, :estimated_delivery_date, :price, :parent,:child, :grand, product_images_attributes: [:product_image, :count])
  end

  def set_product
    @product = Product.find(params[:id])
  end
