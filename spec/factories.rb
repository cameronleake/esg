FactoryGirl.define do

  factory :user do
    first_name "Test"
    last_name "User"
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "secret"
    email_verified false
    email_verification_token "987654321"
  end
  
  factory :article do
    title "Test title"
    blurb "Test blurb content"
    body "Test body content"
    featured_article true
  end
  
  factory :contact do
    name "Example User Name"
    email "TestUser@example.com"
    subject "Some subject text"
    body "Example contact us message"
  end
  
end