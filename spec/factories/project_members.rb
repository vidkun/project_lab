FactoryGirl.define do
  factory :project_member do
    user { FactoryGirl.create(:login_user) }
  end
end