FactoryBot.define do
  factory :user do
    nickname              { 'testuser' }
    email                 { 'test@test.com' }
    password              { 'password01' }
    password_confirmation { password }
    familyname            { '鈴木' }
    firstname             { '一郎' }
    familyname_kana       { 'スズキ' }
    firstname_kana        { 'イチロウ' }
    birth_date            { '2000-01-01' }
  end
end
