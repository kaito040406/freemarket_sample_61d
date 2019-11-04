class ProductsController < ApplicationController
  def index
    
  end

  def edit    
  
  end
  
  def new
    @product = Product.new
    @user = current_user
    10.times { @product.product_images.build }
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
    if @product.seller_id == current_user.id
      @product.destroy
      redirect_to root_path
    else
      #redirect_to show_products_path(product)
    end
  end
  

  private

  def product_params
    # バリデーションエラー回避のため適当なデータ挿入
    params[:product][:seller_id] = 1 #current_userが入るように
    params[:product][:size] = 1
    params[:product][:delivery_method] = 1
    params[:product][:date] = Date.current
    params[:product][:product_images_attributes]["0"][:count] = 1 #[:0][0]だと参照できない
    #ダミーデータ挿入終わり

    params.require(:product).permit(:seller_id, :name, :text, :categry, :status, :size, :date, :delivery_fee, :delivery_method, :delivery_from, :extimated_delivery_date, :price, product_images_attributes: [:product_image, :count])
  end
end