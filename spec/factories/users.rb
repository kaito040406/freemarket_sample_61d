FactoryBot.define do
  factory :user do
    nick_name             {"testman"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    sur_name              {"長谷川"}
    fr_name               {"海斗"}
    sur_name_yomi         {"ハセガワ"}
    first_name_yomi       {"カイト"}
    birthday_year         {"1993"}
    birthday_manth        {"2"}
    birthday_day          {"5"}
    tel_number            {"08024106265"}
    certification         {"0000"}
    address_number        {"533-0022"}
    address_ken           {"滋賀県"}
    address_city          {"長浜市"}
    address_banch         {"311番地"}
  end
end