class CategoriesController < ApplicationController

  def index
    @roots = Category.all.("ancestry ASC").limit(13)
  end
end
