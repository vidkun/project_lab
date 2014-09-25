require 'rails_helper'

RSpec.describe "project_members/destroy.html.erb", :type => :view do

	describe 'has no view' do 
		it 'sees no view' do
			within('html') do
  				expect(page).to have_content('')
  			end
  		end
  	end

end
