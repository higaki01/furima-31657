FactoryBot.define do
  factory :item do
    name              { 'test' }
    description       { 'test' }
    category_id       { 2 }
    condition_id      { 2 }
    shipping_cost_id  { 2 }
    prefecture_id     { 2 }
    shipping_day_id   { 2 }
    price             { 1000 }
    association       :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/image.png'), filename: 'image.png')
    end
  end
end
