FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Phil#{n}" }
    sequence(:last_name) { |n| "Taylor#{n}" }
    password 'Password'
  end
end
