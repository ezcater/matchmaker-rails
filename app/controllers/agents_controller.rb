class AgentsController < ApplicationController
  def show


    @agent = MatchMaker.instance.agents.select{|a| a.object_id == params[:id].to_i}.first

    puts "Agents found #{MatchMaker.instance.agents.map{|a|a.object_id}}"

    @matches = @agent.evaluate_matches(MatchMaker.instance.available_tasks)
    # @article = Article.find(params[:id])
  end

  def create
    MatchMaker.instance.create_agent
    redirect_to tasks_path
  end
end
