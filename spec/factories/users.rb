FactoryBot.define do
  factory :user do
    first_name { 'Peter' }
    last_name { 'Johnstone' }
    sequence(:facebook_id)
  end
end
