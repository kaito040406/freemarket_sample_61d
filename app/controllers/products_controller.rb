class ProductsController < ApplicationController
  def index
    
  end
  
  def new

  end

  def new_copy
    @product = Product.new
    @prefecture = Prefecture.data[1]
  end
end
