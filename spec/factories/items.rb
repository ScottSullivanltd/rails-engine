FactoryBot.define do
  factory :item do
    name { Faker::Device.model_name }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Number.within(range: 0.0..100.0) }
  end
end
