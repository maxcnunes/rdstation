# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pipedrive_config do
    key "MyString"
    value "MyString"
    user nil
  end
end
