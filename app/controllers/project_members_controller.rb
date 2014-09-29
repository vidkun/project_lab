

class ProjectMembersController < ApplicationController
  before_action :set_project

  def new
    redirect_to project_path(@project), notice: "Could not add member" unless @project && current_user.can_add_member?(@project)
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
    @project_member = @project.project_members.find_by(id: params[:id]) if @project 
    notice = current_user.delete_member(@project, @project_member) ? 'Member was successfully deleted' : 'Could not delete member'
    redirect_to project_path(@project), notice: notice
  end

  private
  def project_member_params
    params.require(:project_member).permit(:project_id, :user_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
