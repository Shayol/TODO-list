class ProjectsController < ApplicationController

before_filter :find_project,  only: [:show, :edit, :update, :destroy]

  def new
    @project = Project.new
  end

  def index
    @projects = Project.all
  end

  def create
    @project = Project.create(project_params)
    respond_to do |format|
      if @project.errors.blank?
        format.html { redirect_to root_path, notice: 'Project was successfully created.' }
        format.js
      else
        format.html { render root_path }
      end
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:success] = "project updated!"
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js
      end
    else
      flash.now[:danger] = "Incorrect input"
      render root_path
    end
  end

  def destroy
    @project.destroy
    flash[:info] = "project and all tasks to this project were deleted."
    respond_to do |format|
        format.html {redirect_to root_path}
        format.js
    end
  end


private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
