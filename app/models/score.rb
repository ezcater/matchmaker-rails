class Score < ApplicationRecord
  attr_accessor :agent,
                :task
  CONTEXT_WEIGHT = 2

  def initialize(attributes = nil)
    super
    @agent = agent
    @task = task
  end

  def overall_score
    overall =
      agent_availability *
        skill_match *
        (
          1 +
          CONTEXT_WEIGHT * context_match
        )
    overall
  end

  def agent_availability
    agent.available_brainshare - task.brainshare_required > 0 ? 1 : 0
  end

  def context_match
    (agent.in_memory & task.contexts).size > 0 ? 1 : 0
  end

  def skill_match
    (agent.skills & task.skills_required).size > 0 ? 1 : 0
  end

end
