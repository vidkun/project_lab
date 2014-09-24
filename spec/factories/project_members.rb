FactoryGirl.define do
  factory :project_member do
    user { FactoryGirl.create(:login_user) }
  end

  factory :invalid_project_member do
    user_id "bill"
  end
end