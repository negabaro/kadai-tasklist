class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :find_tasks, only: [:show,:edit,:update,:destroy]
  
  def index
    #@tasks = Task.all
    @tasks = current_user.tasks.all
  end

  def show
    #@task = Task.find(params[:id])
    #@task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end
  
  def edit
    #@task = Task.find(params[:id])
  end
  
  def update
    #@task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :new
    end
    
    
  end
  
  def create
    #@task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "投稿成功しました"
      redirect_to @task
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    
    end
    
  end
  
  def destroy 
    #@task = Task.find(params[:id])
    
    @task.destroy
    flash[:success] = "taskが正常に削除されました。"
    redirect_to tasks_url
    
  end
  
  private
  
  def find_tasks
    @task = current_user.tasks.find_by(id: params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  

end
