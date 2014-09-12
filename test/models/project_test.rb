require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects
  
  test 'project name must not be empty' do
    project = Project.new(name: projects(:one).name)
    assert_not project.errors[:name].any?, "Project name is #{project.name}"
  end

end