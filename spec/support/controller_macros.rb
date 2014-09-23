module ControllerMacros
  def login_user(user_to_login=nil)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = user_to_login || FactoryGirl.create(:user)
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end