# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  first_name      :string
#  last_name       :string
#  facebook_id     :bigint(8)
#  profile_pic_url :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :user do
    first_name { 'Peter' }
    last_name { 'Johnstone' }
    sequence(:facebook_id)
  end
end
