FactoryBot.define do
  factory :product do
    name                        {"テスト"}
    price                       {"300"}
    categry                     {1}
    status                      {1}
    brand                       {1}
    size                        {1}
    date                        {"Sat, 06 Jan 2018"}
    delivery_fee                {1}
    delivery_method             {5}
    delivery_from               {1}
    estimated_delivery_date     {1}
    seller_id                   {1}
    buyer_id                    {1}  
    finished                    {1}  
    text                        {"テスト用"}
  end
end
