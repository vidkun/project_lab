# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do

    factory :first_user do
      name "User Name"
      phone 8018018001
      password 'supersecret'
      email 'user@email.com'
    end
  end
end
