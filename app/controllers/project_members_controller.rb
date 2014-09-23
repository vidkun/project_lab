class ProjectMembersController < ApplicationController
  before_action :set_project

  def new
    @project_member = ProjectMember.new
  end

  def create
    @project_member = @project.project_members.build(project_member_params)

    if @project_member.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def destroy
    @project_member = ProjectMember.find(params[:id])
    @project_member.destroy
    redirect_to project_path(@project), notice: 'Member was successfully deleted.'
  end

  private
  def project_member_params
    params.require(:project_member).permit(:project_id, :user_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
