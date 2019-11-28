class ProductsController < ApplicationController

  require 'payjp'

  before_action :authenticate_user!, except: [:index]
  before_action :set_product, only: [:destroy, :show, :my_details, :purchase_confirmation, :buy]
  before_action :set_category, only: [:index]
  before_action :set_search

  def index
    @product = Product.where(finished: 0).length
    @products = Product.limit(10).order('created_at DESC')
    @products_l = Product.where(parent: 'レディース').limit(10).order('created_at DESC')
    @images_l = ProductImage.where(product_id: @products_l.ids).where.not("count > ?", 1)
    @products_m = Product.where(parent: 'メンズ').limit(10).order('created_at DESC')
    @images_m = ProductImage.where(product_id: @products_m.ids).where.not("count > ?", 1)
    @products_b = Product.where(parent: 'ベビー・キッズ').limit(10).order('created_at DESC')
    @images_b = ProductImage.where(product_id: @products_b.ids).where.not("count > ?", 1)
    @products_i = Product.where(parent: 'インテリア・住まい・小物').limit(10).order('created_at DESC')
    @images_i = ProductImage.where(product_id: @products_i.ids).where.not("count > ?", 1)
    # binding.pry
    if user_signed_in?
      @user = current_user
    end
  end

  def new
    @category_parent = Category.where(ancestry: nil)
    @product = Product.new

    10.times { @product.product_images.build }

    @user = current_user
  end

  def create
    @product = Product.new(product_params)
    if user_signed_in?
      if @product.save
        redirect_to :root
      else
        # redirect_to :failkure
        redirect_to new_user_product_path(current_user)
      end
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
    @search = Product.ransack(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    if @product.seller_id == current_user.id
      grand_name = @product.grand
      @exising_img_count = @product.product_images.size.to_i
      t = 10 - @exising_img_count
      t.times{@product.product_images.build }
      @user = current_user
    else
      redirect_to root_path
    end
    if grand_name != nil
      grand_name = @product.grand
    else
      @category_grand = "no_data"
    end
    @user = current_user
    @search = Product.ransack(params[:id])
  end
  
  def show
    @product = Product.find(params[:id])
    @images = ProductImage.where(product_id: @product.id)
    @image = ProductImage.find_by(product_id: params[:id])
    @prefecture = Prefecture.find(@product.delivery_from).name
    @search = Product.ransack(params[:id])
  end  

  def done
    @product = Product.find(params[:id])
  end

  def my_details
    @image = ProductImage.find(params[:product][:image][:id])
    
    @product = Product.find(params[:id])
    @search = Product.ransack(params[:id])
  end


  def update
    @product = Product.find(params[:id])
    # count =ProductImage.where(id: params[:id]).length
    # ids =ProductImage.where(id: params[:id])
    
    if @product.seller_id == current_user.id
      @product.update!(product_params_up)
    #   k = 0
    #   for i in ids do
    #     @image = ProductImage.find_by(product_id: ids[k][:id])
    #     l = k.to_s
    #     @image.product_image = params[:product][:product_images_attributes][l][:product_image]
    #     binding.pry
    #     # @image.update_attribute(:product_image, params[:product][:product_images_attributes][l][:product_image])
    #     @image.save!
    #     k = k + 1
    #   end   
      redirect_to root_path
    end   
  end  

  def purchase_confirmation
    @product = Product.find(params[:id])
    @images = ProductImage.find_by(product_id: params[:id])
    @users = User.find(current_user.id)
    @users_prefecture = Prefecture.find(@users.address_ken).name
  end

  def set_search
    @search = Product.ransack(name: params[:name_cont])
    @search_parent = Category.where(ancestry: nil)

  end


  def buy #クレジット購入
    @product = Product.find(params[:id])
    unless user_signed_in?
      redirect_to registration_users_path
      flash[:alert] = '購入には新規登録が必要です'
    else
      card = Cards.find_by(user_id: current_user.id)
      if card.blank?
        redirect_to controller: "cards", action: "new"
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
          @product.update_attribute(:buyer_id, current_user.id)
          redirect_to controller: "products", action: 'done'
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
  category = Category.find(params[:grand])
  params[:product][:grand] = category.name
  params[:product][:parent] = params[:product][:category]
  params[:product][:grand_id] = params[:grand]



  params.require(:product).permit(:seller_id, :name, :text, :category, :status, :size, :date, :delivery_fee, :delivery_method, :delivery_from, :estimated_delivery_date, :price, :parent, :child, :grand, :grand_id, product_images_attributes: [:product_image, :count])
end

def set_product
  @product = Product.find(params[:id])
end

def set_category
  @category = Category.where(ancestry: nil).limit(4)
  @category_men = Product.where(parent: "メンズ" ).limit(10)
  @category_women = Product.where(parent: "レディース" ).limit(10)
  @category_kids = Product.where(parent: "ベビー・キッズ" ).limit(10)
  @category_items = Product.where(parent: "インテリア・住まい・小物" ).limit(10)
end

def product_params
  params[:product][:seller_id] = current_user.id
  params[:product][:size] = 1
  params[:product][:date] = Date.current


  params[:product][:child] = params[:child]
  if params[:grand] != nil
    category = Category.find(params[:grand])
  params[:product][:grand] = category.name
  params[:product][:parent] = params[:product][:category]
  params[:product][:grand_id] = params[:grand]
  end

  params.require(:product).permit(:seller_id, :name, :text, :category, :status, :size, :date, :delivery_fee, :delivery_method, :delivery_from, :estimated_delivery_date, :price, :parent, :child, :grand, :grand_id, product_images_attributes: [:product_image, :count])
end

def product_params_up
  params[:product][:seller_id] = current_user.id
  params[:product][:size] = 1
  params[:product][:date] = Date.current
  params[:grand] = 100

  params[:product][:child] = params[:child]
  params[:product][:parent] = params[:product][:category]
  params[:product][:grand_id] = params[:grand]

  params.require(:product).permit(:seller_id, :name, :text, :category, :status, :size, :brand, :date, :delivery_fee, :delivery_method, :delivery_from, :estimated_delivery_date, :price, :parent, :child, :grand, :grand_id, product_images_attributes: [:product_image, :count, :_destroy, :id])
end