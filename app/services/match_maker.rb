class MatchMaker
  include Singleton

  attr_accessor :running
  attr_reader :tasks,
              :agents

  def initialize
    super
    @running = true

    @tasks = []

    500.times do

      case rand()
      when 0..0.5
        @tasks << Task.new(brainshare_required: 0.9,
                           type: :fulfillment_issue)
      when 0.5..0.7
        @tasks << Task.new(brainshare_required: 0.3,
                           type: :caterer_accept)
      else
        @tasks << Task.new(brainshare_required: 0.5,
                           type: :handle_reject)
      end
    end

    @agents = []
    20.times do
      @agents << Agent.new(available_brainshare: 1, name: Faker::Name.name)
    end
  end

  def run
    # while @running
    assign
    # end
  end

  def assign
    @agents.each do |agent|
      @tasks.each do |task|
        next if task.taken
        if (agent.available_brainshare > task.brainshare_required)
          agent.match(task)
          break
        end
      end
    end
  end

end
