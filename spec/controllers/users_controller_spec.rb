require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  login_user(FactoryGirl.create(:login_user))

  describe 'GET index' do
    it 'successfully gets the index page' do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end

    it 'assigns the @users variable' do
      get :index
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe 'GET show' do
    it 'successfully shows a user' do
      user = FactoryGirl.create(:login_user)
      get :show, id: user
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end

     it 'assigns the requested user to @user' do
      user = FactoryGirl.create(:login_user)
      get :show, id: user
      expect(assigns(:user)).to eq(user)
    end
  end

end
