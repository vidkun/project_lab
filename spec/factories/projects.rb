FactoryGirl.define do
  factory :project do
    factory :invalid_project do
      name ''
      description 'MyText7890 MyText7890'
      due_date_at (Time.now - 1.month)
    end

    factory :second_project do
      name 'Second Project Name'
      description 'MyText PartTwo MyText PartTwo MyText PartTwo MyText PartTwo MyText PartTwo'
      due_date_at (Time.now + 1.month)
      association :creator, factory: :login_user
    end

    factory :third_project do
      name 'Third Project Name'
      description 'MyText PartTwo MyText PartTwo MyText PartTwo MyText PartTwo MyText PartTwo'
      due_date_at (Time.now + 1.month)
      association :creator, factory: :login_user
    end

    factory :fourth_project do
      name 'Fourth Project Name'
      description 'MyText PartTwo MyText PartTwo MyText PartTwo MyText PartTwo MyText PartTwo'
      due_date_at (Time.now + 1.month)
      association :creator, factory: :login_user
    end

    factory :project_without_access do
      name 'No Access Project Name'
      description 'MyText PartTwo MyText PartTwo MyText PartTwo MyText PartTwo MyText PartTwo'
      due_date_at (Time.now + 1.month)
      association :creator, factory: :first_user
    end
  end
end