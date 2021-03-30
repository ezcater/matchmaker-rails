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
                :type,
                :state,
                :agent,
                :work_left

  def initialize(attributes = nil)
    super
    @state = :new
    @work_left = @brainshare_required
  end

  def mark_taken! agent
    @state = :taken
    @agent = agent
  end

  def taken?
    @state == :taken
  end

  def complete?
    @state == :complete
  end

  def work_it
    @work_left -= 0.01
    if @work_left <= 0
      @state = :complete
      @work_left = 0
      @agent.complete!(self)
    end
  end
end
