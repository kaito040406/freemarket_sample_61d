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
  end

  def my_details
  end

  def edit
  end  

end
