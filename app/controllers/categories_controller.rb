class CategoriesController < ApplicationController
  before_action :set_category ,except: :index
  before_action :set_search

  def index
    @category_parent = Category.where(ancestry: nil)
  end
  
  def show
    @products = Product.where(params[:id])
    @images = ProductImage.where(params[:id])

  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def set_search
    @search = Product.ransack(name: params[:name_cont])
  end
end