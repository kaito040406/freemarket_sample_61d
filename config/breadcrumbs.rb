crumb :root do
  link "メルカリ", root_path
end


crumb :mypage do
  link "マイページ", users_path
end


crumb :profile do
  link "プロフィール", profile_users_path
  parent :mypage
end

crumb :identification do
  link "本人情報", identification_users_path
  parent :mypage
end

