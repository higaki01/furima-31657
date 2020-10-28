FactoryBot.define do
  factory :form do
    postal_code   { '123-4567' }
    prefecture_id { 2 }
    city          { '市区町村' }
    address       { '番地' }
    building      { '建物名' }
    phone         { '09012345678' }
    token         { 'token' }
  end
end
