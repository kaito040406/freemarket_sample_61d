FactoryBot.define do
  factory :product do
    name                        {Faker::raburaibusannsilyainn.name}
    price                       {Faker::Number.number(4)}
    categry                     {Faker::takamitika.characters(1)}
    status                      {OK}
    brand                       {'キャラクター'}
    size                        {1}
    delivery_fee                {1}
    delivery_method             {'undecided'}
    delivery_from               {'undecided'}
    estimated_delivery_date     {1}
    buyere_id                   {1}    
  end
end
