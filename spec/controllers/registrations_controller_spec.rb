require 'rails_helper'

RSpec.describe RegistrationsController, :type => :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    auth_user = FactoryGirl.create(:login_user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(auth_user)
    allow(controller).to receive(:current_user).and_return(auth_user)
  end

  describe 'POST create' do
    context 'with valid info' do
      it 'should create a user' do
        expect {
          post :create, user: FactoryGirl.attributes_for(:login_user)
          expect(response).to redirect_to(root_path)
        }.to change(User, :count).by(1)
      end
    end

    context 'with invalid info' do
      it 'should not create a user' do
        expect {
          post :create, user: FactoryGirl.attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'located the requested @user', :authorized => true do
        user = User.last

        put :update, {id: user, user: user.attributes.merge(:current_password => 'password') }
        expect(response.status).to be(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
