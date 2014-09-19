require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  fixtures :tasks
  
  test "task name, is_completed must not be empty" do
    task = Task.new(name: tasks(:one).name,
                    description: tasks(:one).description,
                    is_completed: tasks(:one).is_completed)
    assert_not task.errors[:name].any?, "Task name is: #{task.name}"
    assert_not task.errors[:is_completed].any?, "Task is_completed is: #{task.is_completed}"
  end

  test "task must be longer than 50 characters" do
    task = Task.new(name: "Task",
                    description: "Not long",
                    is_completed: false)
    assert task.invalid?
    assert_equal ["is too short (minimum is 50 characters)"], task.errors[:description]
  end  

  test "task delivery time must be more than 0" do
    task = Task.new(name: "Task",
                    description: "Not long",
                    is_completed: false,
                    delivery_minutes: 0)
    assert task.invalid?
    assert_equal ["must be greater than 0"], task.errors[:delivery_minutes]
  end
end

