class Admin::ProjectsController < ApplicationController
  include CanAdmin

  before_action :can_admin?

  def index
    @projects = Project.all
    render 'projects/index'
  end

  def expire_cache
    expire_fragment(controller: params[:controller], action: 'index')
    redirect_to action: :index
  end
end
