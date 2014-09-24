require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  let(:main_user) { create(:login_user) }
  let(:project) { create(:second_project, creator: main_user) }
  let!(:second_project) { create(:third_project, creator: project.creator )}
  let!(:project_without_access) { create(:project_without_access)}

  before { single_login_user(main_user) }

  describe 'GET index' do

    it 'successfully gets the index page' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'assigns the @projects variable' do
      get :index
      expect(assigns(:projects)).to eq([project, second_project])
    end

    it 'only returns projects user can access' do
      get :index
      expect(assigns(:projects)).to eq([project, second_project]) 
      expect(assigns(:projects)).to_not include(project_without_access) 
      # .each do |project| project.creator || project.members include current_user
    end
  end

  describe 'GET show' do
    it 'successfully shows a project a user belongs to' do
      get :show, id: project
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end

     it 'assigns the requested project to @project' do
      get :show, id: project
      expect(assigns(:project)).to eq(project)
    end
  end

  describe 'GET new' do
    it 'should get new' do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    context 'with valid data' do
      it 'should create a project' do
        expect{
          post :create, project: FactoryGirl.attributes_for(:fourth_project)
        }.to change(Project,:count).by(1)
      end

      it 'redirects to the project page upon save' do
        post :create, project: FactoryGirl.attributes_for(:fourth_project)
        expect(response).to redirect_to(Project.last)
      end
    end

    context 'with invalid data' do
      it 'does not save the new project' do
        expect{
          post :create, project: FactoryGirl.attributes_for(:invalid_project)
        }.to_not change(Project,:count)
      end
      
      it 're-renders the new method' do
        post :create, project: FactoryGirl.attributes_for(:invalid_project)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH update' do
    
    context 'with valid attributes' do
      it 'located the requested @project' do
        patch :update, id: project, project: FactoryGirl.attributes_for(:second_project)
        expect(assigns(:project)).to eq(project)      
      end
    
      it "changes @project's attributes" do
        patch :update, id: project, 
          project: FactoryGirl.attributes_for(:project, name: 'newname', description: ('a' * 50))
        project.reload
        expect(project.name).to eq('newname')
        expect(project.description).to eq(('a' * 50))
      end
    
      it 'redirects to the updated project' do
        patch :update, id: project, project: FactoryGirl.attributes_for(:second_project)
        expect(response).to redirect_to project
      end
    end
    
    context 'invalid attributes' do
      it 'located the requested @project' do
        patch :update, id: project, project: FactoryGirl.attributes_for(:invalid_project)
        expect(assigns(:project)).to eq(project)      
      end
      
      it "does not change @project's attributes" do
        patch :update, id: project, 
          project: FactoryGirl.attributes_for(:project, name: 'newname', description: ('a' * 20))
        project.reload
        expect(project.name).to_not eq('newname')
        expect(project.description).to eq(project.description)
      end
      
      it 're-renders the edit method' do
        patch :update, id: project, project: FactoryGirl.attributes_for(:invalid_project)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    
    it 'deletes the project' do
      @project = project
      expect{
        delete :destroy, id: project        
      }.to change(Project,:count).by(-1)
    end
      
    it 'redirects to project#index' do
      delete :destroy, id: project
      expect(response).to redirect_to projects_url
    end
  end

end
