require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  login_user(FactoryGirl.create(:login_user))

  describe "GET index" do
    it "successfully gets the index page" do
      get :index
      expect(response).to be_success
      expect(response).to render_template("index")
    end

    it "assigns the @users variable" do
      get :index
      expect(assigns(:users)).to eq(User.all)
    end
  end

end
