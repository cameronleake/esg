FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "secret"
    email_verified false
    email_verification_token "987654321"
  end
  
  factory :article do
    title "Test title"
    body "Test body content"
  end
  
  factory :contact do
    name "Example User Name"
    email "TestUser@example.com"
    subject "Some subject text"
    body "Example contact us message"
  end
  
end