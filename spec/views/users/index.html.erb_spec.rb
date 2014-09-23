require "rails_helper"

describe "users/index" do
  let(:first_user) { FactoryGirl.create(:login_user, :name => "Grizz")}
  let(:second_user) { FactoryGirl.create(:login_user, :name => "Bo")}

  it "displays all the widgets" do
    assign(:users, User.all )

    render

    expect(rendered).to match first_user.name
    expect(rendered).to match /Bo/
  end
end