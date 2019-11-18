class CategoriesController < ApplicationController
  before_action :set_category ,except: :index

  def index
    @category_parent = Category.where(ancestry: nil)
  end
  
  def show
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end