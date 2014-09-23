require 'rails_helper'

RSpec.describe RegistrationsController, :type => :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'POST create' do
    describe 'success' do
      it 'should create a user' do
        expect {
          post :create, user: FactoryGirl.attributes_for(:first_user)
          expect(response).to redirect_to(root_path)
        }.to change(User, :count).by(1)
      end
    end
  end

end
