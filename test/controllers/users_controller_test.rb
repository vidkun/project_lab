require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @update = {
      name:  'Updated User',
      email: 'new@address.com',
      phone: '(111) 222-3333'
    }
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test 'should get show' do
    get :show, id: @user
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @user
    assert_response :success
  end

  test 'should update a user' do
    patch :update, id: @user, user: @update

    assert_redirected_to user_path(assigns(:user)) 
  end

  test 'should destroy a user' do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  test 'should create a user' do
    assert_difference('User.count') do
      post :create, user: @update
    end

    assert_redirected_to user_path(assigns(:user))  
  end
  
end