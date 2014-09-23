require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

  login_user(FactoryGirl.create(:login_user))
  let(:project) { create(:second_project) }

  describe "GET index" do
    it "successfully gets the index page" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it "assigns the @projects variable" do
      get :index
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe "GET show" do
    it 'successfully shows a project' do
      get :show, id: project
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end

     it "assigns the requested project to @project" do
      get :show, id: project
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "GET new" do
    it "should get new" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST create" do
    context "with valid data" do
      it "should create a project" do
        expect{
          post :create, project: FactoryGirl.attributes_for(:third_project)
        }.to change(Project,:count).by(1)
      end

      it "redirects to the project page upon save" do
        post :create, project: FactoryGirl.attributes_for(:third_project)
        expect(response).to redirect_to(Project.last)
      end
    end

    context "with invalid data" do
      it "does not save the new contact" do
        expect{
          post :create, project: FactoryGirl.attributes_for(:invalid_project)
        }.to_not change(Project,:count)
      end
      
      it "re-renders the new method" do
        post :create, project: FactoryGirl.attributes_for(:invalid_project)
        expect(response).to render_template :new
      end
    end
  end


end
