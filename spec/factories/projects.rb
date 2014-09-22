FactoryGirl.define do
  factory :project do
    factory :first_project do
      name 'First Project Name'
      description 'MyText7890 MyText7890 MyText7890 MyText7890 MyText7890'
      due_date_at 2015-09-09 15:17:16
    end

    factory :second_project do
      name 'Second Project Name'
      description 'MyText PartTwo MyText PartTwo MyText PartTwo MyText PartTwo MyText PartTwo'
      due_date_at 2015-09-09 15:17:38
    end
  end
end