class Api::ProductsController < ApplicationController

  def child #params[:id]親カテゴリのcategoriesテーブル上でのid
    @child_categories = Category.where(ancestry: params[:id])
    respond_to do |format|
      format.html
      format.json #返り値：渡された親カテゴリに属する子カテゴリ群、json
    end
  end

  def grand_child #params[:id]：子カテゴリのid
    unless params[:id].empty?
      data = Category.find_by(name: params[:id])
      g_id = data[:id] + 1 #子カテゴリから一つ下がっているがなぜ？孫カテゴリからでないと[:ancestryで親が取得できない]ということ？孫を持たない子レコードだったら？(おそらく存在しないが)
      g_data = Category.find(g_id)
      g_anc = g_data[:ancestry]
      @grand_child_categories = Category.where(ancestry: g_anc)
      respond_to do |format|
        format.html
        format.json #返り値：渡された子カテゴリに属する孫カテゴリ群、json
      end
    end
  end

  def number
    @images = ProductImage.where(product_id: params[:id])
  end
end