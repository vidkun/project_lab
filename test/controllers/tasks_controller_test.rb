require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @my_task = tasks(:one)
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
      post :create, { project_id: @my_task.project, task: @my_task }
    end

    assert_redirected_to project_task_path(assigns(:task))
  end

end
