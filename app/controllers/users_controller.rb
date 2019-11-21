class UsersController < ApplicationController
  
  before_action :set_search


  def index
  end

  def show
    @count = Product.where(seller_id: current_user.id).length
  end

  def edit
  end

  def log_out
  end

  def profile
  end
  
  def identification
    @data = Prefecture.all
    @user = current_user
  end

  def failkure
  end

  def progress
    @products = Product.where(seller_id: current_user.id)
    @image = ProductImage.where(product_id: @products.ids)
  end

  def privacy
  end

  def tos
  end

  def support
  end

  def compliance
  end

  def set_search
    @search = Product.ransack(name: params[:name_cont])
    @search_parent = Category.where(ancestry: nil)
  end


  
end
