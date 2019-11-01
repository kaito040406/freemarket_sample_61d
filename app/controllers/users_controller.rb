class UsersController < ApplicationController
  

  def index
  end

  def show
  end  

  def profile
  end
  
  def show_profile
    @number = Product.where(seller_id: @user.id, status: 0).length
  end
end
