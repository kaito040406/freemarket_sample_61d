class ProductsController < ApplicationController
  def index
    
  end
  
  def new
    @product = Product.new
  end

  def create
    binding.pry
    @product = Product.new(product_params)
    if @product.save
      @product_image = ProductImage.new(product_image_params)
      if @product_image.save
      else
        @product.delete
      end
    else
      #
    end
    render :new
  end

  private

  def product_params
    # ダミーデータ挿入
    params[:product][:seller_id] = 1#current_userが入るように！<-次やるのはここ予定
    params[:product][:size] = 1
    params[:product][:delivery_method] = 1
    params[:product][:date] = Date.current
    # ダミーデータ挿入終わり
    params.require(:product).permit(:seller_id, :name, :text, :categry, :status, :size, :date, :delivery_fee, :delivery_method, :delivery_from, :extimated_delivery_date, :price)
  end

  def product_image_params
    # ダミーデータ挿入
    params[:count]= 1
    # ダミーデータ挿入終わり
    column_product_image = params[:product][:product_image]
    params.permit(:count).merge(product_id: @product.id, product_image: column_product_image) #productが保存されそのidができた後、それを呼び出さなければならない
  end
end