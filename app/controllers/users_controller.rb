class UsersController < ApplicationController
  

  def index
    @search = Product.ransack(params[:id])
  end

  def show
    @count = Product.where(seller_id: current_user.id).length
    @search = Product.ransack(params[:id])
  end

  def edit
    @search = Product.ransack(params[:id])
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
    @search = Product.ransack(params[:id])
  end

  def progress
    @products = Product.where(seller_id: current_user.id)
    @image = ProductImage.where(product_id: @products.ids)
    @search = Product.ransack(params[:id])
  end

  def privacy
    @search = Product.ransack(params[:id])
  end

  def tos
    @search = Product.ransack(params[:id])
  end

  
end
