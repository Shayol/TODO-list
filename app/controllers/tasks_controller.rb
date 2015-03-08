class TasksController < ApplicationController

before_filter :find_project,  only: [:show, :edit, :update, :new, :create, :destroy, :index, :priority_up, :priority_down]
before_filter :find_task,  only: [:show, :edit, :update, :destroy, :priority_up, :priority_down]

  def index
    @tasks = @project.tasks.all
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.create task_params
    if @task.errors.any?
      flash[:danger] = "Something is wrong. Take a look at your input"
      redirect_to root_path
    else
      priority = @project.tasks.pluck(:priority).last.to_i
      @task.increment!(:priority, (priority+1)
      flash[:success] = "Task created!"
      redirect_to root_path
    end
  end

  def priority_up
    priority = @task.priority
    upper_task = @project.tasks.find_by priority: (priority-1)
    upper_task.increment!(:priority)
    @task.decrement!(:priority)
  end

  def priority_down
    priority = @task.priority
    lower_task = @project.tasks.find_by priority: (priority+1)
    lower_task.decrement!(:priority)
    @task.increment!(:priority)
  end

  def destroy
    @task.destroy
    redirect_to root_path
  end

  private

  def find_task
    @task = @project.tasks.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content)
  end
end
