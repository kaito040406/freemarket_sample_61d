crumb :root do
  link "メルカリ", root_path
end

crumb :product do |product|
  link product.name show_products_path
end

crumb :my_product do |product|
  link product.name, show_products_path
end

crumb :mypage do
  link "マイページ", users_path
end


crumb :profile do
  link "プロフィール", profile_users_path
  parent :mypage
end

crumb :card do
  link "支払い方法", card_users_path
  parent :mypage
end

crumb :logout do
  link "ログアウト", logout_users_path
end

crumb :categories do |category|
  link category.name,category_path
  parent :categories
end

crumb :brand do |brand|
  link "ブランド一覧"
end

crumb :brand do |brund|
  link brand.name, brand_path
  parent :brands
end








