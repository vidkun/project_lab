require 'rails_helper'
require 'spec_helper'

RSpec.describe "project_members/new.html.erb", :type => :view do
include Rails.application.routes.url_helpers
	

	describe 'has an h1 tag' do 
		it 'sees h1 tag' do
			node = page.find('h1')
			node.native.inner_html.should include('Add A New Project Member')
			# it should have_selector("h1") do |content|
   			# content.should (:new, :value => "Add A New Project Member")
  		end
  	end

end

	# it 'sees h1 tag' do  
		# @page = 'project_members/new'
		# @page.should have_tag("h1") 
		# end

# it 'sees h1 tag' do 
		# should have_tag('h1', :exact => 'Add A New Project Member')
		# end
		# it 'sees h1 tag?' do
		# response.should_have_selector("h1")
		# end

	# describe 'Render Form Partial' do
	# 	it 'renders the form partial' do 
	# 	render
	# 	response.should render_template(:partial => "form" )
	# 	end
	# end 

	

