require 'rails_helper'

RSpec.describe Admin::ProjectsController, :type => :controller do

  let(:user_logged_in) { create(:login_user, is_admin: true) }
  let(:not_admin_user) { create(:login_user, is_admin: false) }

  before(:each, :admin_login => true ) { single_login_user(user_logged_in) }
  before(:each, :admin_login => false ) { single_login_user(not_admin_user) }

  describe 'GET index', :admin_login => true do
    it 'successfully gets the index page for admins' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'assigns the @projects variable with only projects owned' do
      get :index
      expect(assigns(:projects)).to eq(Project.all)
    end

  end

  describe 'GET index', :admin_login => false do
    it 'redirects when user is not an admin' do
      get :index
      expect(response).to redirect_to root_path 
    end
  end

end
