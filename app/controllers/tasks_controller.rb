class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.create(task_params)
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
    @task.destroy
    redirect_to project_url(@project), notice: 'Task was successfully deleted.'
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :delivery_minutes, :is_completed, :project_id)
  end

  def set_task
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

end
