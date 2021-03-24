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
  attr_accessor :available_brainshare,
                :skills,
                :in_memory,
                :tasks,
                :name

  def initialize(attributes = nil)
    super
    @tasks = []
  end

  def match task
    @available_brainshare -= task.brainshare_required
    task.mark_taken!
    @tasks << task
  end
end
