require 'rails_helper'

RSpec.describe RegistrationsController, :type => :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'POST create' do
    context 'with valid info' do
      it 'should create a user' do
        expect {
          post :create, user: FactoryGirl.attributes_for(:first_user)
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

  # describe 'PUT update' do
  #   # before :each do
  #   #   @user = FactoryGirl.create(:login_user)
  #   # end
    

  #   context 'with valid attributes' do
  #     login_user(FactoryGirl.create(:login_user), :context, :authorized => true)
  #     # before do 
  #     #   @request.env["devise.mapping"] = Devise.mappings[:user]
  #     #   user = FactoryGirl.create(:login_user)
  #     #   allow(request.env['warden']).to receive(:authenticate!).and_return(user)
  #     #   allow(controller).to receive(:current_user).and_return(user)
  #     # end

  #     it 'located the requested @user', :authorized => true do
  #         # login_user(FactoryGirl.create(:login_user))
  #       user = User.last

  #       put :update, {id: user, user: user.attributes.merge(:current_password => 'password') }
  #       # binding.pry
  #       # expect(response.status).to be(302)
  #       expect(response).to redirect_to(root_path)
  #       # expect(assigns(:user)).to eq(@user)      
  #     end
  #   end
  # end

end
