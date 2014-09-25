require 'rails_helper'

RSpec.describe TasksController, :type => :controller do

  let!(:user) { create(:login_user) }
  before { single_login_user(user) }
  let!(:project) { create(:second_project) }
  let!(:task) { create(:task_one, project: project, creator: user, user: user) }

  describe 'GET index' do
    it 'successfully gets the index page' do
      get :index, project_id: project.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
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

    context 'user is not assigned task' do
      it "doesn't changes task's attributes" do
        user2 = FactoryGirl.create(:login_user)
        project2 = FactoryGirl.create(:second_project,
                                      name: 'no project here',
                                      creator: user2)
        task2 = FactoryGirl.create(:task_one,
                                   user: user2,
                                   name: 'no task here',
                                   project: project2,
                                   creator: user2)

        patch :update, project_id: project2.id, id: task2,
                     task: FactoryGirl.attributes_for(:task_two,
                     name: 'newtaskname', description: ('a' * 50))
        task.reload
        expect(task2.name).to_not eq('newtaskname')
        expect(task2.description).to_not eq(('a' * 50))
      end
    
      it 'redirects back to the project' do
        user2 = FactoryGirl.create(:login_user)
        project2 = FactoryGirl.create(:second_project,
                                      name: 'no project here',
                                      creator: user2)
        task2 = FactoryGirl.create(:task_one,
                                   user: user2,
                                   name: 'no task here',
                                   project: project2,
                                   creator: user2)
        patch :update, project_id: project2.id, id: task2,
                     task: FactoryGirl.attributes_for(:task_two)
        expect(response).to redirect_to project2
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the task' do
      @project = project
      @task = task
      expect{
        delete :destroy, project_id: project.id, id: task
      }.to change(Task,:count).by(-1)
    end
      
    it 'redirects to project' do
      delete :destroy, project_id: project.id, id: task
      expect(response).to redirect_to projects_url
    end

    context 'user is not assigned task' do
      it 'redirects to project' do
        user2 = FactoryGirl.create(:login_user)
        project2 = FactoryGirl.create(:second_project,
                                      name: 'no project here',
                                      creator: user2)
        task2 = FactoryGirl.create(:task_one,
                                   user: user2,
                                   name: 'no task here',
                                   project: project2,
                                   creator: user2)

        delete :destroy, project_id: project2.id, id: task2
        expect(response).to redirect_to project2
      end
    end
  end

end
