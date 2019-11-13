class Api::ProductsController < ApplicationController

  def child
    @child_categories = Category.where(ancestry: params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def grand_child
    unless params[:id].empty?
      data = Category.find_by(name: params[:id])
      g_id = data[:id] + 1
      g_data = Category.find(g_id)
      g_anc = g_data[:ancestry]
      @grand_child_categories = Category.where(ancestry: g_anc)
      respond_to do |format|
        format.html
        format.json
      end
    end
  end
end