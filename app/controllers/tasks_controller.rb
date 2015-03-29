class TasksController < ApplicationController

before_filter :find_project
before_filter :find_task,  except: [:create]

  def index
    @tasks = @project.tasks.all
  end

  def create
    @task = @project.tasks.create task_params
    if @task.errors.any?
      flash[:danger] = "Something is wrong. Take a look at your input"
      render root_path
    else
      lowest_priority = @project.tasks.pluck(:priority).max
      @task.increment!(:priority, (lowest_priority+1))
      flash[:success] = "Task created!"
      end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def priority_up
    priority = @task.priority
    if priority > 1
      @upper_task = @project.tasks.find_by priority: (priority-1)
      @upper_task.increment!(:priority)
      @task.decrement!(:priority)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      redirect_to root_path
    end
  end

  def priority_down
    priority = @task.priority
    lowest_priority = @project.tasks.pluck(:priority).max
    if priority < lowest_priority
      @lower_task = @project.tasks.find_by priority: (priority+1)
      @lower_task.decrement!(:priority)
      @task.increment!(:priority)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      render root_path
    end
  end

  def task_completed
    @task.toggle!(:completed)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def edit
  end

  def update
    @task.update_attributes! task_params
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def find_task
    @task = current_user.tasks.find(params[:id])
  end

  def find_project
    @project = current_user.projects.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:content, :deadline)
  end
end
