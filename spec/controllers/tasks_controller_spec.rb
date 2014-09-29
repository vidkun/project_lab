require 'rails_helper'

RSpec.describe TasksController, :type => :controller do
  let(:current_user) { create(:login_user) }
  let(:project) { create(:second_project, creator: current_user) }
  let(:task) { create(:task_one, project: project, creator: current_user) }

  before { single_login_user(current_user) }

  describe 'GET index' do

    context 'when a user is assigned the task' do
      before { task.update_attributes(user_id: current_user.id) }

      it 'successfully gets the index page' do
        get :index, project_id: project.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end

    context 'when a user is not assigned to the task' do
      let(:other_project) { create(:second_project) }
      let!(:other_task) { create(:task_one, project: other_project) }

      it 'redirects to the root' do
        get :index, project_id: other_project.id
        expect(response).to redirect_to(root_path)
      end
    end
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

    context 'when a user is not assigned to the task' do
      let(:other_project) { create(:second_project) }
      let!(:other_task) { create(:task_one, project: other_project) }

      it 'redirects to the root' do
        get :show, project_id: other_project.id, id: other_task
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET new' do
    it 'should get new' do
      get :new, project_id: project.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    context 'with valid data' do
      it 'should create a task' do
        expect{
          post :create, project_id: project.id, task: FactoryGirl.attributes_for(:task_two)
        }.to change(Task,:count).by(1)
      end

      it 'redirects to the task page upon save' do
        post :create, project_id: project.id, task: FactoryGirl.attributes_for(:task_two)
        expect(response).to redirect_to(Project.last)
      end
    end

    context 'with invalid data' do
      it 'does not save the new task' do
        expect{
          post :create, project_id: project.id, task: FactoryGirl.attributes_for(:invalid_task)
        }.to_not change(Task,:count)
      end
      
      it 're-renders the new method' do
        post :create, project_id: project.id, task: FactoryGirl.attributes_for(:invalid_task)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'located the requested @task' do
        patch :update, project_id: project.id, id: task,
                     task: FactoryGirl.attributes_for(:task_two)
        expect(assigns(:task)).to eq(task)      
      end
    
      it "changes @task's attributes" do
        patch :update, project_id: project.id, id: task,
                     task: FactoryGirl.attributes_for(:task_two,
                     name: 'newtaskname', description: ('a' * 50))
        task.reload
        expect(task.name).to eq('newtaskname')
        expect(task.description).to eq(('a' * 50))
      end
    
      it 'redirects to the updated project' do
        patch :update, project_id: project.id, id: task,
                     task: FactoryGirl.attributes_for(:task_two)
        expect(response).to redirect_to Project.last
      end
    end
    
    context 'invalid attributes' do
      it 'located the requested @task' do
        patch :update, project_id: project.id, id: task,
                     task: FactoryGirl.attributes_for(:invalid_task)
        expect(assigns(:task)).to eq(task)      
      end
      
      it "does not change @task's attributes" do
        patch :update, project_id: project.id, id: task,
                     task: FactoryGirl.attributes_for(:invalid_task, description: ('a' * 20))
        task.reload
        expect(task.name).to_not eq('newname')
        expect(task.description).to eq(task.description)
      end
      
      it 're-renders the edit method' do
        patch :update, project_id: project.id, id: task,
                     task: FactoryGirl.attributes_for(:invalid_task)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do

    context 'when the user is the owner of the task' do
      let!(:task_owned) { create(:task_one, creator: current_user, project: project)}

      it 'deletes the task' do
        expect{
          delete :destroy, project_id: project.id, id: task_owned
        }.to change(Task,:count).by(-1)
      end

      it 'redirects to project' do
        delete :destroy, project_id: project.id, id: task_owned
        expect(response).to redirect_to projects_url
      end
    end

    context 'when the user is not the owner of the task' do
      let!(:task_not_owned) { create(:task_one, project: project)}

      it 'deletes the task' do
        expect{
          delete :destroy, project_id: project.id, id: task_not_owned
        }.to_not change(Task,:count)
      end
    end
  end

end
