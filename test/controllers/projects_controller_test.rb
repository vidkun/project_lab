require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @update = {
      name:       'Update Project',
      description: 'Yay....Moar work...sssssddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
      due_date_at:   '2015-10-12 06:06:06'
    }
  end

  test 'should get projects index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test 'should show a project' do
    get :show, id: @project
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create a project' do
    assert_difference('Project.count') do
      post :create, project: @update
    end

    assert_redirected_to project_path(assigns(:project))  
  end

  test 'should get edit' do
    get :edit, id: @project
    assert_response :success
  end

  test 'should update a project' do
    patch :update, id: @project, project: @update

    assert_redirected_to project_path(assigns(:project)) 
  end

  test 'should destroy a project' do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end

end