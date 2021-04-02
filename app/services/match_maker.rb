class MatchMaker
  include Singleton

  attr_accessor :running
  attr_reader :tasks,
              :agents

  def initialize
    super
    @running = false

    @tasks = []
    @agents = []


    Thread.new do
      while true do
        run
      end
    end
  end


  def create_agent
    @agents << Agent.new
  end

  def create_tasks
    10.times do
      case rand()
      when 0..0.2
        @tasks << Task.new_phone_task
      when 0.2..0.4
        @tasks << Task.new_relish_task
      when 0.4..0.5
        @tasks << Task.new_fi_task
      when 0.5..0.7
        @tasks << Task.new_ca_task
      else
        @tasks << Task.new_handle_reject_task
      end
    end
  end

  def run
    if @running
      remove_completed
      work
      assign
      puts "run"
    else
      puts "skip"
    end
    sleep(1)
  end

  def remove_completed
    @tasks.each do |task|
      if task.complete?
        puts "complete #{task}"
        @tasks.delete task
      end
    end
  end

  def work
    @tasks.each do |task|
      if task.taken?
        puts "work #{task}"
        task.work_it
      end
    end
  end

  def assign
    @agents.each do |agent|
      agent.process_matches
    end
  end

  def available_tasks
    @tasks.select { |t| t.new? }
  end

  def start
    @running = true
  end

  def stop
    @running = false
  end
end
