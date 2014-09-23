# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do

    factory :task_one do
      name "Task name"
      description "This is the task description. This is the task description. This is the task description."
      delivery_minutes 20
    end
  end
end
