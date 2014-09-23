require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

  login_user(FactoryGirl.create(:login_user))
  subject { create(:second_project) }

  describe "GET index" do
    it "successfully gets the index page" do
      get :index
      expect(response).to be_success
      expect(response).to render_template("index")
    end

    it "assigns the @projects variable" do
      get :index
      expect(assigns(:projects)).to eq(Project.all)
    end
  end
end
