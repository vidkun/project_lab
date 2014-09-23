require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

  login_user(FactoryGirl.create(:login_user))
  let(:project) { create(:second_project) }

  describe "GET index" do
    it "successfully gets the index page" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end

    it "assigns the @projects variable" do
      get :index
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe "GET project" do
    it 'successfully shows a project' do
      get :show, id: project
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    it "should get new" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  # describe "POST create" do
  #   it "should create a project" do
  #     post :create, project: FactoryGirl.attributes_for(:third_project)
  #     expect(response).to be_success
  #     expect(assigns(:project)).to be_a_new(Project)

  #   end

  #   # it "redirects to the project page upon save" do
  #   #   post :create, project: FactoryGirl.attributes_for(:third_project)
  #   #   expect(response).to redirect_to(project)
  #   # end
  # end

# test "should create a project" do
#     assert_difference('Project.count') do
#       post :create, project: @update
#     end

#     assert_redirected_to project_path(assigns(:project))  
#   end


end
