require 'rails_helper'

RSpec.describe ProjectMembersController, :type => :controller do

  login_user(FactoryGirl.create(:login_user))
  let(:project) { create(:second_project) }

  describe 'GET new' do
    it 'returns http success' do
      get :new, project_id: project.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    context 'with valid info' do
      it 'should create a new project member' do
        expect{
          post :create, project_id: project.id,
                        project_member: FactoryGirl.attributes_for(:project_member)
        }.to change(ProjectMember,:count).by(1)
      end
    end
  end

  describe 'DELETE destroy' do
    it "should redirect to the project's page" do
      delete :destroy, project_id: project.id, id: FactoryGirl.create(:project_member)
      expect(response).to redirect_to project
    end
  end

end
