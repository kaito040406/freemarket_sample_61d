class UsersController < ApplicationController
  

  def index
  end

  def show
    @count = Product.where(seller_id: current_user.id).length
    @search = Product.ransack(params[:id])
  end

  def edit
  end

  def log_out
    @search = Product.ransack(params[:id])
  end

  def profile
    @search = Product.ransack(params[:id])
  end
  
  def identification
    @data = Prefecture.all
    @user = current_user
    @search = Product.ransack(params[:id])
  end

  def failkure
  end

  def progress
    @products = Product.where(seller_id: current_user.id)
    @image = ProductImage.where(product_id: @products.ids)
    @search = Product.ransack(params[:id])
  end

  def privacy
  end

  
end
