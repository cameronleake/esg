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
  end
  
  
  factory :contact do
    name "Example User Name"
    email "TestUser@example.com"
    subject "Some subject text"
    body "Example contact us message"
  end
  
  
  factory :shopping_cart do
    cart_token "123456789"
  end


  factory :category do
    name "Test Category"
  end
  

  factory :resource do
    name "Test Resource"
    description "Test Description"
    price_type "Free"
    price_in_cents 0
  end
end