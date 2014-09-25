# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do

    factory :task_one do
      name "Task name"
      description "This is the task description. This is the task description. This is the task description."
      delivery_minutes 20
      association :creator
      association :user
    end

    factory :task_two do
      name "Task name two"
      description "This is the task description. This is the task description. This is the task description."
      delivery_minutes 20
    end

    factory :invalid_task do
      name ""
      description "This is the task description. This is the task description."
      delivery_minutes "four"
    end
  end
end
