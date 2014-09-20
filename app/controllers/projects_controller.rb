class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :titleize_params, only: [:edit, :update]
  before_action :find_user

  def index
    @projects = Project.all.order(:due_date_at)
  end

  def show
    @tasks = @project.tasks
  end

  def new
    @project = Project.new
    @project.user_id = current_user.id
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    titleize_params
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
  end

  private
  def project_params
    params.require(:project).permit(:name, :description, :due_date_at, :user_id, tasks_attributes: [:id, :name, :description, :is_completed, :delivery_minutes, :project_id, :_destroy, :user_id])
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def titleize_params
    @project.name = @project.name.titleize
  end

  def find_user
    @user = current_user
    @users = User.all
  end
end
