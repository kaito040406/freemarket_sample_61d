crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", "/users/#{current_user.id}"
end


crumb :profile do
  link "プロフィール", profile_users_path
  parent :mypage
end

crumb :identification do
  link "本人情報", identification_users_path
  parent :mypage
end

crumb :progress do
  link "出品した商品 - 出品中", progress_users_path
  parent :mypage
end

crumb :my_details do
  link "出品商品画面", progress_users_path
  parent :progress
end


crumb :cards do
  link "支払い方法", "/cards"
  parent :mypage
end

crumb :log_out do
  link "ログアウト", log_out_users_path
  parent :mypage
end


crumb :credit do
  link "クレジットカード情報入力", credit_users_path
  parent :cards
end

crumb :privacy do
  link "プライバシーポリシー", privacy_users_path
end
