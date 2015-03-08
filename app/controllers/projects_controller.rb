class ProjectsController < ApplicationController

before_filter :find_project,  only: [:show, :edit, :update, :destroy]

  def new
    @project = Project.new
  end

  def show
    @tasks = @project.order('tasks.priority DESC').all
  end

  def index
    @projects = Project.all
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
    if @project.save
      format.html { redirect_to root_path, notice: 'Project was successfully created.' }
      format.js
    else
      format.html { render root_path }
      format.js
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:success] = "project updated!"
      redirect_to @project
    else
      flash.now[:danger] = "Incorrect input"
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    flash[:info] = "project and all tasks to this project were deleted."
    redirect_to root_path
 end


private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
