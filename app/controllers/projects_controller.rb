class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @action = CreatesProject.new project_params_hash
    @action.create

    redirect_to projects_path
  end

  private
    def project_params_hash
      { name: params[:project][:name],
        task_string: params[:project][:tasks] }
    end
end
