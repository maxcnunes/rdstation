# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "MyString"
    last_name "MyString"
    email "MyString"
    company "MyString"
    job_title "MyString"
    phone "MyString"
    website "MyString"
    user nil
  end
end
