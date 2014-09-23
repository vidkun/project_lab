# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do

    factory :first_user do
      name "User Name"
      phone 8018018001
      password 'supersecret'
      email 'user@email.com'
    end

    factory :login_user do
      name "username"
      phone 8018018001
      password 'password'
      email "username+#{SecureRandom.random_number(10000)}@email.com"
    end
  end
end
