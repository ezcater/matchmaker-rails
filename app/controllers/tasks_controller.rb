class TasksController < ApplicationController
  def index
    MatchMaker.instance.run

    # @articles = Article.all
    #
    #
    @tasks = MatchMaker.instance.tasks
    @agents = MatchMaker.instance.agents
  end

  def show
    # @article = Article.find(params[:id])
  end
end
