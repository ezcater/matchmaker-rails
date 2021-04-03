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
  MAX_MEMORY = 8

  def initialize(attributes = nil)
    super
    @tasks = []
    @skills = []
    @in_memory = []
    @available_brainshare = 1
    @name = Faker::Name.name

    case rand()
    when 0..0.2
      @skills = %w(tasks phones)
    when 0.2..0.4
      @skills = %w(tasks)
    when 0.4..0.6
      @skills = %w(relish_sms phones)
    else
      @skills = %w(relish_sms)
    end
  end

  def match task
    task.mark_taken(self)
    @in_memory |= task.contexts
    if @in_memory.size > MAX_MEMORY
      (@in_memory.size - MAX_MEMORY).times do
        @in_memory.shift
      end
    end
    @tasks << task
  end

  def complete! task
    @tasks.delete task
  end

  def available_brainshare
    @tasks.inject(1) { |memo, t| memo - t.brainshare_required }
  end

  def process_matches
    best = evaluate_matches(MatchMaker.instance.available_tasks).first

    return if best.nil?
    puts "Agent #{@name} #{@skills} Best match #{best[0].overall_score} Task #{best[1].type}"
    if best[0].overall_score > 0.5
      match(best[1])
    end
  end

  def evaluate_matches tasks
    res = tasks.map do |task|
      [Score.new(agent: self, task: task), task]
    end.sort_by { |a| -a[0].overall_score }
    res
  end

end
