# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_comment do
    commenter "MyString"
    body "MyText"
    article nil
  end
end
