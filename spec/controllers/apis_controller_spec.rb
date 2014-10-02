require 'rails_helper'

RSpec.describe ApisController, :type => :controller do

  describe "GET github_callback" do
    it "returns http success" do
      get :github_callback
      expect(response).to be_success
    end
  end

end
