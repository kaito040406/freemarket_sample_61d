class ProductsController < ApplicationController
  def index
    
  end
  
  def new
    @product = Product.new
  end

  def create
    # @product = Product.new(product_params)
    # if @product.save
      @product_image = ProductImage.new(product_image_params)
      if @product_image.save
      else
        # @product.delete
      end
    # else

    # end
    render :new
  end

  private

  # def product_params
  #   params[:product][:seller_id] = 1
  #   params[:product][:size] = 1
  #   params[:product][:delivery_method] = 1
  #   params[:product][:date] = Date.current
  #   params.require(:product).permit(:seller_id, :name, :text, :categry, :status, :size, :date, :delivery_fee, :delivery_method, :delivery_from, :extimated_delivery_date, :price)
  # end

  def product_image_params
    params[:count]= 1
    column_product_image = params[:product][:product_image]
    kaerichi = params.permit(:count).merge(product_id: 2, product_image: column_product_image) #productが保存されそのidができた後、それを呼び出さなければならない
    binding.pry
    return kaerichi
  end
end