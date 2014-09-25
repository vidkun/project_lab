require 'rails_helper'
require 'spec_helper'

RSpec.describe "project_members/new.html.erb", :type => :view do
include Rails.application.routes.url_helpers
	
	#I have no idea... but it works?
	describe 'has an h1 tag' do 
		it 'sees h1 tag' do
			within('h1') do
  				expect(page).to have_content('Add A New Project Member')
  			end
  		end
  	end
  	#I think this works too? - looks for 'Back & Submit'
  	#in the form partial for project_members 
  	#... insert 'ihavenoideawhatimdoingdog.jpeg'
  	describe 'has a form' do 
		it 'sees form' do
			within('form') do
  				expect(page).to have_content('Back')
  				expect(page).to have_content('Submit')
  			end
  		end
  	end
  	#it doesn't fail bundle exec rspec...still prob
  	#no bueno 
end
