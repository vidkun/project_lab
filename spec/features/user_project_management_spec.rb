require "rails_helper"

feature "User project management" do
  background do 
    @user = User.find_by(name: 'Sam')
    @user1 = User.find_by(name: 'Fred')
    log_in_with(@user.email, 'password')
  end
    
  scenario "As a user, I can login to the Project Manager and see the projects I have access to" do
    visit root_path
    # Expect user to be logged in and see their email at the top of the page
    expect(page.html).to have_link(@user.email, user_path(@user))

    expect(page).to have_content("Sign Out")
    expect(page).to have_content("This is the project one.")
  end

  scenario "As a user, I can see other peoples’ tasks and their current status" do
    visit "/users/#{@user1.id}"
    
    expect(page).to have_content('Fred')
    if @user1.tasks.any?
      expect(page).to have_content('Incomplete' || 'Complete')
      expect(page).to have_content("#{@user1.tasks.first.name}")
    end
  end

end