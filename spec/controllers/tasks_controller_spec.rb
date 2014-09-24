require 'rails_helper'

RSpec.describe TasksController, :type => :controller do

login_user(FactoryGirl.create(:login_user))
  let(:project) { create(:second_project) }
  let(:task) { create(:task_one, project: project) }

  describe 'GET index' do
    it 'successfully gets the index page' do
      get :index, project_id: project.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    # it 'assigns the @task variable' do
    #   get :index, project_id: project.id
    #   expect(assigns(:task)).to eq([task])
    # end
  end

  describe 'GET show' do
    it 'successfully shows a task' do
      get :show, project_id: project.id, id: task
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end

     it 'assigns the requested task to @task' do
      get :show, project_id: project.id, id: task
      expect(assigns(:task)).to eq(task)
    end
  end

  # describe 'GET new' do
  #   it 'should get new' do
  #     get :new
  #     expect(response).to be_success
  #     expect(response).to have_http_status(200)
  #   end
  # end

  # describe 'POST create' do
  #   context 'with valid data' do
  #     it 'should create a project' do
  #       expect{
  #         post :create, project: FactoryGirl.attributes_for(:third_project)
  #       }.to change(Project,:count).by(1)
  #     end

  #     it 'redirects to the project page upon save' do
  #       post :create, project: FactoryGirl.attributes_for(:third_project)
  #       expect(response).to redirect_to(Project.last)
  #     end
  #   end

  #   context 'with invalid data' do
  #     it 'does not save the new project' do
  #       expect{
  #         post :create, project: FactoryGirl.attributes_for(:invalid_project)
  #       }.to_not change(Project,:count)
  #     end
      
  #     it 're-renders the new method' do
  #       post :create, project: FactoryGirl.attributes_for(:invalid_project)
  #       expect(response).to render_template :new
  #     end
  #   end
  # end

  # describe 'PUT update' do
  #   before :each do
  #     @project = project
  #   end
    
  #   context 'with valid attributes' do
  #     it 'located the requested @project' do
  #       put :update, id: @project, project: FactoryGirl.attributes_for(:second_project)
  #       expect(assigns(:project)).to eq(@project)      
  #     end
    
  #     it "changes @project's attributes" do
  #       put :update, id: @project, 
  #         project: FactoryGirl.attributes_for(:project, name: 'newname', description: ('a' * 50))
  #       @project.reload
  #       expect(@project.name).to eq('newname')
  #       expect(@project.description).to eq(('a' * 50))
  #     end
    
  #     it 'redirects to the updated project' do
  #       put :update, id: @project, project: FactoryGirl.attributes_for(:second_project)
  #       expect(response).to redirect_to @project
  #     end
  #   end
    
  #   context 'invalid attributes' do
  #     it 'located the requested @project' do
  #       put :update, id: @project, project: FactoryGirl.attributes_for(:invalid_project)
  #       expect(assigns(:project)).to eq(@project)      
  #     end
      
  #     it "does not change @project's attributes" do
  #       put :update, id: @project, 
  #         project: FactoryGirl.attributes_for(:project, name: 'newname', description: ('a' * 20))
  #       @project.reload
  #       expect(@project.name).to_not eq('newname')
  #       expect(@project.description).to eq(project.description)
  #     end
      
  #     it 're-renders the edit method' do
  #       put :update, id: @project, project: FactoryGirl.attributes_for(:invalid_project)
  #       expect(response).to render_template :edit
  #     end
  #   end
  # end

  # describe 'DELETE destroy' do
  #   before :each do
  #     @project = project
  #   end
    
  #   it 'deletes the project' do
  #     expect{
  #       delete :destroy, id: @project        
  #     }.to change(Project,:count).by(-1)
  #   end
      
  #   it 'redirects to project#index' do
  #     delete :destroy, id: @project
  #     expect(response).to redirect_to projects_url
  #   end
  # end

end
