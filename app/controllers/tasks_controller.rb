class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :find_user


  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
    @task.creator = current_user
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)
    @task.creator = current_user

    if @task.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @project = Project.find(params[:project_id])
    if @task.update(task_params)
      redirect_to @project, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    notice = current_user.delete_task(@task) ? 'Task was successfully deleted.' : 'Could not delete task'
    redirect_to projects_url, notice: notice
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :delivery_minutes, :is_completed, :project_id, :user_id, :creator)
  end

  def set_task
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  def find_user
    @user = current_user
    @users = User.all
  end

end
