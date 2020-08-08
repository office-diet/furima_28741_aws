FactoryBot.define do
  factory :item_purchase do
    Faker::Config.locale = :ja
    postal_code     { "#{rand(100..999)}-#{rand(1000..9999)}" }
    prefecture_id   { rand(1..47) }
    town            { Faker::Lorem.sentence }
    address         { "#{rand(1..10)}-#{rand(1..10)}" }
    building        { Faker::Name.name }
    price           { rand(300..9_999_999) }
    tel             { rand(1_000_000_000..10_000_000_000) }
    token           { ENV['PAYJP_PUBLIC_KEY'] }
  end
end
