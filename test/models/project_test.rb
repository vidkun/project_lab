require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects
  
  test "project name must not be empty" do
    project = Project.new(name: projects(:one).name)
    assert project.invalid?
    assert project.errors[:name].any?
  end

end

