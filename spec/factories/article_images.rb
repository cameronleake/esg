# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article_image do
    image "MyString"
    article_id 1
  end
end
