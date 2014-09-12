require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  fixtures :tasks
  
  test 'task name, description, and is_completed must not be empty' do
    task = Task.new(name: tasks(:one).name,
                    description: tasks(:one).description,
                    is_completed: tasks(:one).is_completed)
    assert_not task.errors[:name].any?, "Task name is: #{task.name}"
    assert_not task.errors[:description].any?, "Task description is: #{task.description}"
    assert_not task.errors[:is_completed].any?, "Task is_completed is: #{task.is_completed}"
  end

end