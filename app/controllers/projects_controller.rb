class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    action = CreatesProject.new project_params_hash
    if action.create
      redirect_to projects_path
    else
      render :new
    end
  end

  private
    def project_params_hash
      { name: params[:project][:name],
        task_string: params[:project][:tasks] }
    end
end
