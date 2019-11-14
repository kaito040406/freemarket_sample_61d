class UsersController < ApplicationController
  

  def index
  end

  def show
    
  end  

  def log_out

  end

  def profile
  end

  def identification
    @data = Prefecture.all
    @user = current_user
  end

  def progress
    @products = Product.all
    @image = ProductImage.all
    @user = User.all
  end

  def my_details
    @product=Product.all
    @image = ProductImage.all
    @user = User.all
  end

  def edit
  end  
end
