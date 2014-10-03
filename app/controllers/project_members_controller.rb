

class ProjectMembersController < ApplicationController
  before_action :set_project

  def new
    redirect_to project_path(@project), notice: "Could not add member" unless @project && current_user.can_add_member?(@project)
    @project_member = ProjectMember.new
  end

  def create
    @project_member = @project.project_members.build(project_member_params)

    respond_to do |format|
      if @project_member.save
        format.html { redirect_to(project_path(@project)) }
        format.js
      else
        format.js
      end
    end 
  end

  def destroy
    @project_member = @project.project_members.find_by(id: params[:id]) if @project 
    @notice = current_user.delete_member(@project, @project_member) ? 'Member was successfully deleted' : 'Could not delete member'

    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: notice }
      format.js
    end 
  end

  private
  def project_member_params
    params.require(:project_member).permit(:project_id, :user_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
