crumb :root do
  link "メルカリ", root_path
end


crumb :mypage do
  link "マイページ", "#{current_user.id}"

end


crumb :profile do
  link "プロフィール", profile_users_path
  parent :mypage
end

crumb :identification do
  link "本人情報", identification_users_path
  parent :mypage
end

crumb :my_details do
  link "出品した商品 - 出品中", ""
  parent :mypage
end

crumb :cards do
  link "支払い方法", card_users_path
  parent :mypage
end








