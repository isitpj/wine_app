FactoryBot.define do
  factory :facebook_message do
    name { 'Default Message' }
    category { :fallback }
  end
end
