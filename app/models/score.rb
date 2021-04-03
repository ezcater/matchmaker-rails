class Score < ApplicationRecord
  attr_accessor :agent,
                :task
  CONTEXT_WEIGHT = 3
  CUSTOMER_OPPORTUNITY_WEIGHT = 2
  TASK_OPPORTUNITY_WEIGHT = 2

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
            (CONTEXT_WEIGHT * context_match) +
            (CUSTOMER_OPPORTUNITY_WEIGHT * customer_opportunity) +
            (TASK_OPPORTUNITY_WEIGHT * task_opportunity)
        )
    overall
  end

  def agent_availability
    agent.available_brainshare - task.brainshare_required > 0 ? 1 : 0
  end

  def customer_opportunity
    [task.eny1b / 5000.0, 1].min
  end

  def task_opportunity
    task.task_opportunity
  end

  def context_match
    matching_contexts.size > 0 ? 1 : 0
  end

  def matching_contexts
    (agent.in_memory & task.contexts)
  end

  def skill_match
    (agent.skills & task.skills_required).size > 0 ? 1 : 0
  end

  def chance_to_reduce_fi

  end

  def immediacy

  end

  def feasibility
    #time of day
  end

  def legacy_order_task_weight
    [200/500]
  end

end
