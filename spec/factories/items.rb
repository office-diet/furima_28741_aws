FactoryBot.define do
  factory :item do
    Faker::Config.locale = :ja
    name  { Faker::Name.name }
    text  { Faker::Lorem.sentence }
    price { rand(300..9_999_999) }
    category_id       { rand(1..10) }
    condition_id      { rand(1..6) }
    postage_id        { rand(1..2) }
    prefecture_id     { rand(1..47) }
    shipment_delay_id { rand(1..3) }
  end
end
