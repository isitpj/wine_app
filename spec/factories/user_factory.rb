FactoryBot.define do
  factory :user do
    first_name { 'Peter' }
    last_name { 'Johnstone' }
    facebook_id { 1234 }
  end
end
