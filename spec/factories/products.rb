FactoryBot.define do
  factory :product do
    seller_id                   {1}
    name                        {"テスト"}
    text                        {"テスト用"}
    price                       {1000}
    category                     {"レディース"}
    status                      {"新品、未使用"}
    brand                       {1}
    size                        {1}
    date                        {"Sat, 06 Jan 2018"}
    delivery_fee                {"着払い(購入者負担)"}
    delivery_method             {"未定"}
    delivery_from               {1}
    estimated_delivery_date     {"1~2日で発送"}
    buyer_id                    {1}  
    finished                    {1}
  end
end
