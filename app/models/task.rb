# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Task < ApplicationRecord
  attr_accessor :brainshare_required,
                :skills_required,
                :type,
                :state,
                :agent,
                :contexts,
                :work_left,
                :eny1b,
                :task_opportunity

  def self.new_fi_task
    Task.new(brainshare_required: 0.9,
             skills_required: ["tasks"],
             contexts: ["customer:#{rand(10)}"],
             task_opportunity: 0.7,
             type: :fulfillment_issue
    )
  end

  def self.new_ca_task
    Task.new(brainshare_required: 0.3,
             skills_required: ["tasks"],
             contexts: ["caterer:#{rand(10)}"],
             task_opportunity: 0.2,
             type: :caterer_accept)
  end

  def self.new_relish_task
    Task.new(brainshare_required: 0.3,
             skills_required: ["relish_sms"],
             contexts: ["relish_customer:#{rand(10)}"],
             type: :relish_sms)
  end

  def self.new_handle_reject_task
    Task.new(brainshare_required: 0.5,
             skills_required: ["tasks"],
             contexts: ["customer:#{rand(10)}",
                        "order:#{rand(10)}"],
             type: :handle_reject)
  end

  def self.new_phone_task
    Task.new(brainshare_required: 0.5,
             skills_required: ["phones"],
             contexts: ["customer:#{rand(10)}",
                        "order:#{rand(10)}"],
             task_opportunity: 1,
             type: :phone_task)
  end

  def initialize(attributes = nil)
    super
    @state = :new
    @work_left = @brainshare_required
    @eny1b = rand(3000) + 200
    @task_opportunity ||= 0.5
  end

  def mark_taken agent
    @state = :taken
    @agent = agent
  end

  def taken?
    @state == :taken
  end

  def complete?
    @state == :complete
  end

  def new?
    @state == :new
  end

  def work_it
    @work_left -= 0.1
    if @work_left <= 0
      @state = :complete
      @work_left = 0
      @agent.complete!(self)
    end
  end
end
