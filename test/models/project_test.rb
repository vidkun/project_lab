require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects
  
  test "project name must not be empty" do
    project = Project.new(name: projects(:one).name)
    assert_not project.errors[:name].any?, "Project name is #{project.name}"
  end

  test "project name must be unique" do
    project = Project.new(name: projects(:one).name,
                          description: "12345678901234567890123456789012345678901234567890",
                          due_date_at: projects(:one).due_date_at)
    assert project.invalid?
    assert_equal ["has already been taken"], project.errors[:name]
  end 

  test "date must be in the future" do
    project = Project.new(name: "Project name",
                          description: "12345678901234567890123456789012345678901234567890",
                          due_date_at: '2013-09-09 15:17:38')
    assert project.invalid?
    assert_equal ["can't be in the past"], project.errors[:due_date_at]
  end 

end

