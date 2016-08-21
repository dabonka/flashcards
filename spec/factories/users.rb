FactoryGirl.define do
  factory :user do
    email "adminadmin@admin.com"
    password "password"
    password_confirmation "password"
    locale "en"
  end
end
