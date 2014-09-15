require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @my_task = tasks(:one)
    @update = { name: "New project",
                description: "This is the descriptionThis is the descriptionThis is the descriptionThis is the descriptionThis is the description",
                delivery_minutes: 20,
                is_completed: false }
  end

  test "should get index" do
    get :index, project_id: @my_task.project
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test "should get show" do
    get :show, { project_id: @my_task.project, id: @my_task }
    assert_response :success
  end

  test "should get new" do
    get :new, project_id: @my_task.project
    assert_response :success
  end

  test "should get edit" do
    get :edit, { project_id: @my_task.project, id: @my_task }
    assert_response :success
  end

  test "should create a task" do
    assert_difference('Task.count') do
      post :create, task: @update, project_id: @project
    end

    assert_redirected_to project_path(assigns(:project))
  end

end
