class TasksController < ApplicationController
  def index
    # @articles = Article.all
    #
    #
    @tasks = MatchMaker.instance.tasks
    @agents = MatchMaker.instance.agents
  end

  def show
    # @article = Article.find(params[:id])
  end

  def create
    MatchMaker.instance.create_tasks
    redirect_to tasks_path
  end

  def start
    MatchMaker.instance.start
    redirect_to tasks_path
  end

  def stop
    MatchMaker.instance.stop
    redirect_to tasks_path
  end
end
