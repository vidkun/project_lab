require 'rails_helper'
require 'spec_helper'

RSpec.describe "project_members/create.html.erb", :type => :view do
include Rails.application.routes.url_helpers

 describe 'has a header' do 
		it 'sees h1' do
			within('h1') do
  				expect(page).to have_content('ProjectMembers#create')
  			end
  		end
  	end

  describe 'has a paragraph' do 
		it 'sees p' do
			within('p') do
  				expect(page).to have_content('Find me in app/views/project_members/create.html.erb')
  			end
  		end
  	end
  #noideawhatimdoingdog.jpg? 
  #it passes? 

end
