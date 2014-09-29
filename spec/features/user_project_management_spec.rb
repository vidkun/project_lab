require "rails_helper"

feature "User project management" do
  scenario "As a user, I can login to the Project Manager and see the projects I have access to" do
    user = User.find_by(name: 'Sam')

    log_in_with(user.email, 'password')

    # Expect user to be logged in and see their email at the top of the page
    expect(page.html).to have_link(user.email, user_path(user))

    expect(page).to have_content("Sign Out")
    expect(page).to have_content("This is the project one.")
  end
end