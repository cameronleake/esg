FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "secret"
  end
  
  factory :article do
    title "Test title"
    body "Test body content"
  end
  
end