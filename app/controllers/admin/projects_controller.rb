class Admin::ProjectsController < ApplicationController
  include CanAdmin

  before_action :can_admin?

  def index
    @projects = Project.all
    render 'projects/index'
  end
end
