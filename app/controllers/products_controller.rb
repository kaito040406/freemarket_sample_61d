class ProductsController < ApplicationController
  def index
    
  end
  
  def new
    @product = Product.new
  end

  def new_copy
    @product = Product.new
  end
end
