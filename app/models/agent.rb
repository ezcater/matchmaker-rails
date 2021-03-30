# == Schema Information
#
# Table name: agents
#
#  id                   :bigint           not null, primary key
#  available_brainshare :float
#  skills               :string           default([]), is an Array
#  in_memory            :string           default([]), is an Array
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Agent < ApplicationRecord
  attr_accessor :skills,
                :in_memory,
                :tasks,
                :name

  def initialize(attributes = nil)
    super
    @tasks = []
  end

  def match task
    task.mark_taken!(self)
    @tasks << task
  end

  def complete! task
    @tasks.delete task
  end

  def available_brainshare
    @tasks.inject(1){|memo, t| memo - t.brainshare_required}
  end
end
