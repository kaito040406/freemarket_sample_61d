FactoryBot.define do
  factory :cards do
    customer_id {1}
    card_id {1111111111111111}
    association :user, factory: :user
  end
end
